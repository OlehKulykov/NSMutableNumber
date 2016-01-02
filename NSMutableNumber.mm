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


#import "NSMutableNumber.h"
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

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeFromEncoded(const char * type)
{
	const NSUInteger t = *(const uint16_t*)type;
	/// can't hardcode @encode result, just use in runtime.
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

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeIsUnsigned(const NSUInteger type)
{
	switch (type) {
		case NSMNumberCType_unsigned_long_long:
		case NSMNumberCType_unsigned_char:
		case NSMNumberCType_unsigned_short:
		case NSMNumberCType_unsigned_int:
		case NSMNumberCType_unsigned_long:
		case NSMNumberCType_NSUInteger:
			return 1;
			break;
		default: break; }
	return 0;
}

FOUNDATION_STATIC_INLINE NSUInteger NSMNumberCTypeIsReal(const NSUInteger type)
{
	switch (type) {
		case NSMNumberCType_float:
		case NSMNumberCType_double:
			return 1;
			break;
		default: break; }
	return 0;
}

struct number_s
{
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

	void copyDataToNumber(struct number_s * number)
	{
		number->data = data;
		number->typeValue = typeValue;
		number->reservedValue = reservedValue;
		number->serviceInfo = serviceInfo;
	}

	pthread_mutex_t _mutex;
	void lock() { pthread_mutex_lock(&_mutex); }
	void unlock() { pthread_mutex_unlock(&_mutex); }

	number_s()
	{
		pthread_mutexattr_t attr;
		if (pthread_mutexattr_init(&attr) == 0)
		{
			if (pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE) == 0) pthread_mutex_init(&_mutex, &attr);
			pthread_mutexattr_destroy(&attr);
		}
	}

	~number_s()
	{
		pthread_mutex_destroy(&_mutex);
	}

	const char * objCtype() const { return (const char*)type; }

	template<typename T> T get()
	{
		T r = 0;
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeU: r = (T)data.u; break;
			case NSMNumberValueTypeI: r = (T)data.i; break;
			case NSMNumberValueTypeR: r = (T)data.r; break;
			default: break;
		};
		unlock();
		return r;
	}

	template<typename T> void set(const T & value, const uint8_t type)
	{
		lock();
		reserved[0] = sizeof(T);
		reserved[1] = type;
		typeValue = *(const uint16_t*)@encode(T);
		switch (type) {
			case NSMNumberValueTypeU: data.u = value;  break;
			case NSMNumberValueTypeI: data.i = value;  break;
			case NSMNumberValueTypeR: data.r = value;  break;
			default: break; };
		unlock();
	}

	void getValue(void * value)
	{
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeU: {
				switch (reserved[0]) {
					case sizeof(uint8_t): *(uint8_t*)value = this->get<uint8_t>(); break;
					case sizeof(uint16_t): *(uint16_t*)value = this->get<uint16_t>(); break;
					case sizeof(uint32_t): *(uint32_t*)value = this->get<uint32_t>(); break;
					case sizeof(uint64_t): *(uint64_t*)value = this->get<uint64_t>(); break;
					default: break; }
			} break;
			case NSMNumberValueTypeI: {
				switch (reserved[0]) {
					case sizeof(int8_t): *(int8_t*)value = this->get<int8_t>(); break;
					case sizeof(int16_t): *(int16_t*)value = this->get<int16_t>(); break;
					case sizeof(int32_t): *(int32_t*)value = this->get<int32_t>(); break;
					case sizeof(int64_t): *(int64_t*)value = this->get<int64_t>(); break;
					default: break; }
			} break;
			case NSMNumberValueTypeR: {
				switch (reserved[0]) {
					case sizeof(float): *(float*)value = this->get<float>(); break;
					case sizeof(double): *(double*)value = this->get<double>(); break;
					default: break; }
			} break;
			default: break; }
		unlock();
	}

	void copyToString(char * buff, const size_t buffLen)
	{
		lock();
		switch (reserved[1]) {
			case NSMNumberValueTypeI: snprintf(buff, buffLen, "%lli", data.i); break;
			case NSMNumberValueTypeU: snprintf(buff, buffLen, "%llu", data.u); break;
			case NSMNumberValueTypeR:
				if (reserved[0] == sizeof(float)) snprintf(buff, buffLen, "%.6g", (float)data.r);
				else if (reserved[0] == sizeof(double)) snprintf(buff, buffLen, "%.15g", (double)data.r);
				break;
			default: strncpy(buff, "(null)", 6); break; }
		unlock();
	}

	BOOL isUnsigned() const { return (reserved[1] == NSMNumberValueTypeU); }

	BOOL isReal() const { return (reserved[1] == NSMNumberValueTypeR); }
};

@interface NSMutableNumber()
{
@private
	struct number_s _number;
}
@end

@implementation NSMutableNumber

#pragma mark - NSSecureCoding
+ (BOOL) supportsSecureCoding
{
	return NO;
}

#pragma mark - NSCopying
- (id) copyWithZone:(nullable NSZone *) zone
{
	_number.lock();
	NSMutableNumber * n = [[NSMutableNumber alloc] init];
	_number.copyDataToNumber(&n->_number);
	_number.unlock();
	return n;
}

#pragma mark - NSCoding
- (void) encodeWithCoder:(NSCoder *) coder
{
	if (coder)
	{
		_number.lock();
		const size_t size1 = sizeof(_number.data);
		const size_t size2 = sizeof(_number.serviceInfo);
		uint8_t buff[size1 + size2];
		memcpy(buff, &_number.data, size1);
		memcpy(&buff[size1], &_number.serviceInfo, size2);
		_number.unlock();

		[coder encodeBytes:buff length:size1 + size2 forKey:@"b"];
	}
}

#pragma mark - NSValue, service getters
- (const char *) objCType
{
	return _number.objCtype();
}

- (void) getValue:(nonnull void *) value
{
	NSParameterAssert(value);
	_number.getValue(value);
}

- (nonnull instancetype) initWithBytes:(nonnull const void *) value objCType:(nonnull const char *) type
{
	self = [super init];
	if (self)
	{
		NSParameterAssert(value);
		NSParameterAssert(type);

		switch (NSMNumberCTypeFromEncoded(type)) {
			case NSMNumberCType_int: _number.set<int>(*(const int*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_char: _number.set<char>(*(const char*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_double: _number.set<double>(*(const double*)value, NSMNumberValueTypeR); break;
			case NSMNumberCType_float: _number.set<float>(*(const float*)value, NSMNumberValueTypeR); break;
			case NSMNumberCType_BOOL: _number.set<char>((*(const BOOL*)value) ? (char)1 : (char)0, NSMNumberValueTypeI); break;
			case NSMNumberCType_NSInteger: _number.set<NSInteger>(*(const NSInteger*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_NSUInteger: _number.set<NSUInteger>(*(const NSUInteger*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_long_long: _number.set<long long>(*(const long long*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_long_long: _number.set<unsigned long long>(*(const unsigned long long*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_unsigned_char: _number.set<unsigned char>(*(const unsigned char*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_short: _number.set<short>(*(const short*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_short: _number.set<unsigned short>(*(const unsigned short*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_unsigned_int: _number.set<unsigned int>(*(const unsigned int*)value, NSMNumberValueTypeU); break;
			case NSMNumberCType_long: _number.set<long>(*(const long*)value, NSMNumberValueTypeI); break;
			case NSMNumberCType_unsigned_long: _number.set<unsigned long>(*(const unsigned long*)value, NSMNumberValueTypeU); break;
			default: break; }
	}
	return self;
}

- (nullable instancetype) initWithCoder:(nullable NSCoder *) decoder
{
	self = [super init];
	if (self)
	{
		if (decoder)
		{
			const size_t size1 = sizeof(_number.data);
			const size_t size2 = sizeof(_number.serviceInfo);
			NSUInteger len = 0;
			const uint8_t * bytes = [decoder decodeBytesForKey:@"b" returnedLength:&len];
			if (bytes && len == (size1 + size2))
			{
				memcpy(&_number.data, bytes, size1);
				memcpy(&_number.serviceInfo, &bytes[size1], size2);
				return self;
			}
		}
	}
	return nil;
}

#pragma mark - NSObject init
- (nonnull instancetype) init
{
	self = [super init];
	if (self) _number.set<int>(0, NSMNumberValueTypeI);
	return self;
}

- (Class) classForCoder
{
	return [NSMutableNumber class];
}

- (Class) classForKeyedArchiver
{
	return [NSMutableNumber class];
}

- (id) copy
{
	return [self copyWithZone:nil];
}

- (id) mutableCopy
{
	_number.lock();
	NSMutableNumber * number = [[NSMutableNumber alloc] init];
	_number.copyDataToNumber(&number->_number);
	_number.unlock();
	return number;
}

- (nonnull NSNumber *) immutableCopy
{
	NSNumber * immutableNumber = nil;
	_number.lock();
	if (_number.isUnsigned())
	{
		if (_number.reserved[0] == sizeof(unsigned char)) immutableNumber = [[NSNumber alloc] initWithUnsignedChar:_number.get<unsigned char>()];
		else if (_number.reserved[0] == sizeof(unsigned short)) immutableNumber = [[NSNumber alloc] initWithUnsignedShort:_number.get<unsigned short>()];
		else if (_number.reserved[0] == sizeof(unsigned int)) immutableNumber = [[NSNumber alloc] initWithUnsignedInt:_number.get<unsigned int>()];
		else immutableNumber = [[NSNumber alloc] initWithUnsignedLongLong:_number.get<unsigned long long>()];
	}
	else if (_number.isReal())
	{
		if (_number.reserved[0] == sizeof(float)) immutableNumber = [[NSNumber alloc] initWithFloat:_number.get<float>()];
		else immutableNumber = [[NSNumber alloc] initWithDouble:_number.get<double>()];
	}
	else
	{
		if (_number.reserved[0] == sizeof(char)) immutableNumber = [[NSNumber alloc] initWithChar:_number.get<char>()];
		else if (_number.reserved[0] == sizeof(short)) immutableNumber = [[NSNumber alloc] initWithShort:_number.get<short>()];
		else if (_number.reserved[0] == sizeof(int)) immutableNumber = [[NSNumber alloc] initWithInt:_number.get<int>()];
		else immutableNumber = [[NSNumber alloc] initWithLongLong:_number.get<long long>()];
	}
	_number.unlock();
	return immutableNumber;
}

- (BOOL) isKindOfClass:(Class) aClass
{
	if (aClass == [NSNumber class] || aClass == [NSValue class])
	{
		return YES;
	}
	return [super isKindOfClass:aClass];
}

#pragma mark - NSMutableNumber initializers
- (nonnull NSMutableNumber *) initWithChar:(char) value
{
	self = [super init];
	if (self) _number.set<char>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedChar:(unsigned char) value
{
	self = [super init];
	if (self) _number.set<unsigned char>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithShort:(short) value
{
	self = [super init];
	if (self) _number.set<short>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedShort:(unsigned short) value
{
	self = [super init];
	if (self) _number.set<unsigned short>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithInt:(int) value
{
	self = [super init];
	if (self) _number.set<int>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedInt:(unsigned int) value
{
	self = [super init];
	if (self) _number.set<unsigned int>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithLong:(long) value
{
	self = [super init];
	if (self) _number.set<long>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedLong:(unsigned long) value
{
	self = [super init];
	if (self) _number.set<unsigned long>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithLongLong:(long long) value
{
	self = [super init];
	if (self) _number.set<long long>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedLongLong:(unsigned long long) value
{
	self = [super init];
	if (self) _number.set<unsigned long long>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithFloat:(float) value
{
	self = [super init];
	if (self) _number.set<float>(value, NSMNumberValueTypeR);
	return self;
}

- (nonnull NSMutableNumber *) initWithDouble:(double) value
{
	self = [super init];
	if (self) _number.set<double>(value, NSMNumberValueTypeR);
	return self;
}

- (nonnull NSMutableNumber *) initWithBool:(BOOL) value
{
	self = [super init];
	if (self) _number.set<char>(value ? (char)1 : (char)0, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithInteger:(NSInteger) value
{
	self = [super init];
	if (self) _number.set<NSInteger>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedInteger:(NSUInteger) value
{
	self = [super init];
	if (self) _number.set<NSUInteger>(value, NSMNumberValueTypeU);
	return self;
}

#pragma mark - NSMutableNumber typed getters & setters
- (char) charValue
{
	return _number.get<char>();
}

- (void) setCharValue:(char) value
{
	_number.set<char>(value, NSMNumberValueTypeI);
}

- (unsigned char) unsignedCharValue
{
	return _number.get<unsigned char>();
}

- (void) setUnsignedCharValue:(unsigned char) value
{
	_number.set<unsigned char>(value, NSMNumberValueTypeU);
}

- (short) shortValue
{
	return _number.get<short>();
}

- (void) setShortValue:(short) value
{
	_number.set<short>(value, NSMNumberValueTypeI);
}

- (unsigned short) unsignedShortValue
{
	return _number.get<unsigned short>();
}

- (void) setUnsignedShortValue:(unsigned short) value
{
	_number.set<unsigned short>(value, NSMNumberValueTypeU);
}

- (int) intValue
{
	return _number.get<int>();
}

- (void) setIntValue:(int) value
{
	_number.set<int>(value, NSMNumberValueTypeI);
}

- (unsigned int) unsignedIntValue
{
	return _number.get<unsigned int>();
}

- (void) setUnsignedIntValue:(unsigned int) value
{
	_number.set<unsigned int>(value, NSMNumberValueTypeU);
}

- (long) longValue
{
	return _number.get<long>();
}

- (void) setLongValue:(long) value
{
	_number.set<long>(value, NSMNumberValueTypeI);
}

- (unsigned long) unsignedLongValue
{
	return _number.get<unsigned long>();
}

- (void) setUnsignedLongValue:(unsigned long) value
{
	_number.set<unsigned long>(value, NSMNumberValueTypeU);
}

- (long long) longLongValue
{
	return _number.get<long long>();
}

- (void) setLongLongValue:(long long) value
{
	_number.set<long long>(value, NSMNumberValueTypeI);
}

- (unsigned long long) unsignedLongLongValue
{
	return _number.get<unsigned long long>();
}

- (void) setUnsignedLongLongValue:(unsigned long long) value
{
	_number.set<unsigned long long>(value, NSMNumberValueTypeU);
}

- (float) floatValue
{
	return _number.get<float>();
}

- (void) setFloatValue:(float) value
{
	_number.set<float>(value, NSMNumberValueTypeR);
}

- (double) doubleValue
{
	return _number.get<double>();
}

- (void) setDoubleValue:(double) value
{
	_number.set<double>(value, NSMNumberValueTypeR);
}

- (BOOL) boolValue
{
	/// check any contained value(casted to longes signed integer) is zero.
	return (_number.get<long long>() == 0) ? NO : YES;
}

- (void) setBoolValue:(BOOL) value
{
	_number.set<char>(value ? (char)1 : (char)0, NSMNumberValueTypeI);
}

- (NSInteger) integerValue
{
	return _number.get<NSInteger>();
}

- (void) setIntegerValue:(NSInteger) value
{
	_number.set<NSInteger>(value, NSMNumberValueTypeI);
}

- (NSUInteger) unsignedIntegerValue
{
	return _number.get<NSUInteger>();
}

- (void) setUnsignedIntegerValue:(NSUInteger) value
{
	_number.set<NSUInteger>(value, NSMNumberValueTypeU);
}

- (NSString * _Nonnull) stringValue
{
	char buff[44];
	_number.copyToString(buff, 44);
	return [NSString stringWithUTF8String:buff];
}

- (NSComparisonResult) compareWithSigned:(nullable id) otherNumber
{
	const long long right = [otherNumber longLongValue];
	if (_number.isUnsigned())
	{
		if (right < 0) return NSOrderedDescending; // right is negative, while self is positive
		const unsigned long long left = _number.get<unsigned long long>();
		if (left == right)
		{
			return NSOrderedSame;
		}
		else if (left < right) return NSOrderedAscending;
	}
	else
	{
		const long long left = _number.get<long long>();
		if (left == right)
		{
			return NSOrderedSame;
		}
		else if (left < right) return NSOrderedAscending;
	}
	return NSOrderedDescending;
}

- (NSComparisonResult) compareWithUnsigned:(nullable id) otherNumber
{
	const unsigned long long right = [otherNumber unsignedLongLongValue];
	if (_number.isUnsigned())
	{
		const unsigned long long left = _number.get<unsigned long long>();
		if (left == right)
		{
			return NSOrderedSame;
		}
		else if (left < right) return NSOrderedAscending;
	}
	else
	{
		const long long left = _number.get<long long>();
		if (left < 0) return NSOrderedAscending; // self is negative, while right is positive
		if (right == left)
		{
			return NSOrderedSame;
		}
		else if (right > left) return NSOrderedAscending;
	}
	return NSOrderedDescending;
}

- (NSComparisonResult) compareWithReal:(nullable id) otherNumber
{
	const double left = _number.get<double>();
	const double right = [otherNumber doubleValue];
	if (left == right)
	{
		return NSOrderedSame;
	}
	else if (left < right) return NSOrderedAscending;
	return NSOrderedDescending;
}

- (NSComparisonResult) compare:(nullable id) object
{
	NSComparisonResult r = NSOrderedDescending; // left operand is greater than the right(nil or unsupported)
	_number.lock();
	if (object && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSMutableNumber class]]))
	{
		const NSUInteger type = NSMNumberCTypeFromEncoded([object objCType]);
		if (NSMNumberCTypeIsUnsigned(type)) r = [self compareWithUnsigned:object];
		else if (NSMNumberCTypeIsReal(type)) r = [self compareWithReal:object];
		r = [self compareWithSigned:object];
	}
	_number.unlock();
	return r;
}

- (BOOL) isEqualToNumber:(nullable id) number
{
	return ([self compare:number] == NSOrderedSame);
}

- (BOOL) isEqual:(id) object
{
	return ([self compare:object] == NSOrderedSame);
}

- (nonnull NSString *) descriptionWithLocale:(nullable id) locale
{
	return self.stringValue;
}

- (NSString *) debugDescription
{
	return self.stringValue;
}

- (NSString *) description
{
	return self.stringValue;
}

- (NSUInteger) hash
{
	return [[self immutableCopy] hash];
}

@end

#pragma mark - NSMutableNumber static initializers
@implementation NSMutableNumber(NSMutableNumberCreation)

+ (nonnull NSMutableNumber *) numberWithChar:(char) number { return [[NSMutableNumber alloc] initWithChar:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedChar:(unsigned char) number { return [[NSMutableNumber alloc] initWithUnsignedChar:number]; }
+ (nonnull NSMutableNumber *) numberWithShort:(short) number { return [[NSMutableNumber alloc] initWithShort:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedShort:(unsigned short) number { return [[NSMutableNumber alloc] initWithUnsignedShort:number]; }
+ (nonnull NSMutableNumber *) numberWithInt:(int) number { return [[NSMutableNumber alloc] initWithInt:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedInt:(unsigned int) number { return [[NSMutableNumber alloc] initWithUnsignedInt:number]; }
+ (nonnull NSMutableNumber *) numberWithLong:(long) number { return [[NSMutableNumber alloc] initWithLong:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedLong:(unsigned long) number { return [[NSMutableNumber alloc] initWithUnsignedLong:number]; }
+ (nonnull NSMutableNumber *) numberWithLongLong:(long long) number { return [[NSMutableNumber alloc] initWithLongLong:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedLongLong:(unsigned long long) number { return [[NSMutableNumber alloc] initWithUnsignedLongLong:number]; }
+ (nonnull NSMutableNumber *) numberWithFloat:(float) number { return [[NSMutableNumber alloc] initWithFloat:number]; }
+ (nonnull NSMutableNumber *) numberWithDouble:(double) number { return [[NSMutableNumber alloc] initWithDouble:number]; }
+ (nonnull NSMutableNumber *) numberWithBool:(BOOL) number { return [[NSMutableNumber alloc] initWithBool:number]; }
+ (nonnull NSMutableNumber *) numberWithInteger:(NSInteger) number { return [[NSMutableNumber alloc] initWithInteger:number]; }
+ (nonnull NSMutableNumber *) numberWithUnsignedInteger:(NSUInteger) number { return [[NSMutableNumber alloc] initWithUnsignedInteger:number]; }

@end


#pragma mark - NSNumber mutable copy
@implementation NSNumber(NSMutableNumberMutableCopy)

- (id) mutableCopy
{
	uint8_t value[32];
	[self getValue:value];
	return [[NSMutableNumber alloc] initWithBytes:value objCType:[self objCType]];
}

@end
