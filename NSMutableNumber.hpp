/*
 *   Copyright (c) 2015 - 2016 Kulykov Oleh <info@resident.name>
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy
 *   of this software and associated documentation files (the "Software"), to deal
 *   in the Software without restriction, including without limitation the rights
 *   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *   copies of the Software, and to permit persons to whom the Software is
 *   furnished to do so, subject to the following conditions:
 *
 *   The above copyright notice and this permission notice shall be included in
 *   all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *   THE SOFTWARE.
 */


#ifndef __NSMUTABLENUMBER_HPP__
#define __NSMUTABLENUMBER_HPP__

#import <Foundation/Foundation.h>
#include <pthread.h>

#define NSMNumberValueTypeU 0
#define NSMNumberValueTypeI 1
#define NSMNumberValueTypeR 2
#define NSMNumberCType_int 1
#define NSMNumberCType_long_long 2
#define NSMNumberCType_unsigned_long_long 3
#define NSMNumberCType_char 4
#define NSMNumberCType_unsigned_char 5
#define NSMNumberCType_short 6
#define NSMNumberCType_unsigned_short 7
#define NSMNumberCType_unsigned_int 8
#define NSMNumberCType_long 9
#define NSMNumberCType_unsigned_long 10
#define NSMNumberCType_float 11
#define NSMNumberCType_double 12
#define NSMNumberCType_BOOL 13
#define NSMNumberCType_NSInteger 14
#define NSMNumberCType_NSUInteger 15

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeFromEncoded(const char * type) {
	const NSUInteger t = *(const uint16_t*)type; /// can't hardcode @encode result, just use in runtime.
	if (t == *(const uint16_t*)@encode(int)) return NSMNumberCType_int;
	else if (t == *(const uint16_t*)@encode(BOOL)) return NSMNumberCType_BOOL;
	else if (t == *(const uint16_t*)@encode(double)) return NSMNumberCType_double;
	else if (t == *(const uint16_t*)@encode(float)) return NSMNumberCType_float;
	else if (t == *(const uint16_t*)@encode(char)) return NSMNumberCType_char;
	else if (t == *(const uint16_t*)@encode(NSInteger)) return NSMNumberCType_NSInteger;
	else if (t == *(const uint16_t*)@encode(NSUInteger)) return NSMNumberCType_NSUInteger;
	else if (t == *(const uint16_t*)@encode(long long)) return NSMNumberCType_long_long;
	else if (t == *(const uint16_t*)@encode(unsigned long long)) return NSMNumberCType_unsigned_long_long;
	else if (t == *(const uint16_t*)@encode(unsigned char)) return NSMNumberCType_unsigned_char;
	else if (t == *(const uint16_t*)@encode(short)) return NSMNumberCType_short;
	else if (t == *(const uint16_t*)@encode(unsigned short)) return NSMNumberCType_unsigned_short;
	else if (t == *(const uint16_t*)@encode(unsigned int)) return NSMNumberCType_unsigned_int;
	else if (t == *(const uint16_t*)@encode(long)) return NSMNumberCType_long;
	else if (t == *(const uint16_t*)@encode(unsigned long)) return NSMNumberCType_unsigned_long;
	return 0;
}

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeIsUnsigned(const NSUInteger type) {
	switch (type) {
		case NSMNumberCType_unsigned_long_long:
		case NSMNumberCType_unsigned_char:
		case NSMNumberCType_unsigned_short:
		case NSMNumberCType_unsigned_int:
		case NSMNumberCType_unsigned_long:
		case NSMNumberCType_NSUInteger:
			return 1;
			break;
		default: break;
	}
	return 0;
}

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeIsReal(const NSUInteger type) {
	switch (type) {
		case NSMNumberCType_float:
		case NSMNumberCType_double:
			return 1;
			break;
		default: break;
	}
	return 0;
}

class NSMPCNumber {
public:
	union { // data
		double r;
		int64_t i;
		uint64_t u;
		BOOL b;
	} data;

	union { // service info
		struct {
			union { // objCtype
				int8_t type[2];
				uint16_t typeValue;
			};
			union { // value type
				uint8_t reserved[2];
				uint16_t reservedValue;
			};
		};
		uint32_t serviceInfo;
	};

	void copyDataToNumber(NSMPCNumber * number) {
		number->data = data;
		number->typeValue = typeValue;
		number->reservedValue = reservedValue;
		number->serviceInfo = serviceInfo;
	}

	pthread_mutex_t _mutex;
	
	void lock() {
		pthread_mutex_lock(&_mutex);
	}
	
	void unlock() {
		pthread_mutex_unlock(&_mutex);
	}

	NSMPCNumber() {
		pthread_mutexattr_t attr;
		if (pthread_mutexattr_init(&attr) == 0) {
			if (pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE) == 0) pthread_mutex_init(&_mutex, &attr);
			pthread_mutexattr_destroy(&attr);
		}
	}

	~NSMPCNumber() {
		pthread_mutex_destroy(&_mutex);
	}

	const char * objCtype() const { return (const char*)type; }

	template<typename T> T get() {
		T r = 0;
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeU: r = (T)data.u; break;
			case NSMNumberValueTypeI: r = (T)data.i; break;
			case NSMNumberValueTypeR: r = (T)data.r; break;
			default: break;
		}
		unlock();
		return r;
	}

	template<typename T> void set(const T & value, const uint8_t type) {
		lock();
		reserved[0] = sizeof(T);
		reserved[1] = type;
		typeValue = *(const uint16_t*)@encode(T);
		switch (type) {
			case NSMNumberValueTypeU: data.u = value;  break;
			case NSMNumberValueTypeI: data.i = value;  break;
			case NSMNumberValueTypeR: data.r = value;  break;
			default: break;
		}
		unlock();
	}

	void getValue(void * value) {
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeU: {
				switch (reserved[0]) {
					case sizeof(uint8_t): *(uint8_t*)value = this->get<uint8_t>(); break;
					case sizeof(uint16_t): *(uint16_t*)value = this->get<uint16_t>(); break;
					case sizeof(uint32_t): *(uint32_t*)value = this->get<uint32_t>(); break;
					case sizeof(uint64_t): *(uint64_t*)value = this->get<uint64_t>(); break;
					default: break;
				}
			} break;
			case NSMNumberValueTypeI: {
				switch (reserved[0]) {
					case sizeof(int8_t): *(int8_t*)value = this->get<int8_t>(); break;
					case sizeof(int16_t): *(int16_t*)value = this->get<int16_t>(); break;
					case sizeof(int32_t): *(int32_t*)value = this->get<int32_t>(); break;
					case sizeof(int64_t): *(int64_t*)value = this->get<int64_t>(); break;
					default: break;
				}
			} break;
			case NSMNumberValueTypeR: {
				switch (reserved[0]) {
					case sizeof(float): *(float*)value = this->get<float>(); break;
					case sizeof(double): *(double*)value = this->get<double>(); break;
					default: break;
				}
			} break;
			default: break;
		}
		unlock();
	}

	void copyToString(char * buff, const size_t buffLen) {
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeI: snprintf(buff, buffLen, "%lli", data.i); break;
			case NSMNumberValueTypeU: snprintf(buff, buffLen, "%llu", data.u); break;
			case NSMNumberValueTypeR:
				if (reserved[0] == sizeof(float)) snprintf(buff, buffLen, "%.6g", (float)data.r);
				else if (reserved[0] == sizeof(double)) snprintf(buff, buffLen, "%.15g", (double)data.r);
				break;
			default: strncpy(buff, "(null)", 6); break;
		}
		unlock();
	}

	BOOL isUnsigned() const {
		return (reserved[1] == NSMNumberValueTypeU);
	}

	BOOL isReal() const {
		return (reserved[1] == NSMNumberValueTypeR);
	}

	void setWithBytesAndObjCType(const void * value, const char * type) {
		switch (NSMNumberCTypeFromEncoded(type)) {
			case NSMNumberCType_int: this->set<int>(*(const int*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_char: this->set<char>(*(const char*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_double: this->set<double>(*(const double*)value, NSMNumberValueTypeR); break;
			case NSMNumberCType_float: this->set<float>(*(const float*)value, NSMNumberValueTypeR); break;
			case NSMNumberCType_BOOL: this->set<char>((*(const BOOL*)value) ? (char)1 : (char)0, NSMNumberValueTypeI); break;
			case NSMNumberCType_NSInteger: this->set<NSInteger>(*(const NSInteger*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_NSUInteger: this->set<NSUInteger>(*(const NSUInteger*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_long_long: this->set<long long>(*(const long long*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_long_long: this->set<unsigned long long>(*(const unsigned long long*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_unsigned_char: this->set<unsigned char>(*(const unsigned char*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_short: this->set<short>(*(const short*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_short: this->set<unsigned short>(*(const unsigned short*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_unsigned_int: this->set<unsigned int>(*(const unsigned int*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_long: this->set<long>(*(const long*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_long: this->set<unsigned long>(*(const unsigned long*)value, NSMNumberValueTypeU); break;
			default: break;
		}
	}
};

#endif 
