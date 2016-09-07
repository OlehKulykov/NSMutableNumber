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
#include "NSMutableNumber.hpp"

@interface NSMutableNumber() {
@private
	NSMPCNumber _number;
}
@end

@implementation NSMutableNumber

#pragma mark - NSSecureCoding
+ (BOOL) supportsSecureCoding {
	return NO;
}

#pragma mark - NSCopying
- (id) copyWithZone:(nullable NSZone *) zone {
	_number.lock();
	NSMutableNumber * n = [[NSMutableNumber alloc] init];
	_number.copyDataToNumber(&n->_number);
	_number.unlock();
	return n;
}

#pragma mark - NSCoding
- (void) encodeWithCoder:(NSCoder *) coder {
	if (coder) {
		_number.lock();
		const size_t size1 = sizeof(_number.data), size2 = sizeof(_number.serviceInfo);
		uint8_t buff[size1 + size2];
		memcpy(buff, &_number.data, size1);
		memcpy(&buff[size1], &_number.serviceInfo, size2);
		_number.unlock();
		[coder encodeBytes:buff length:size1 + size2 forKey:@"b"];
	}
}

#pragma mark - NSValue, service getters
- (const char *) objCType {
	return _number.objCtype();
}

- (void) getValue:(nonnull void *) value {
	NSParameterAssert(value);
	_number.getValue(value);
}

- (nonnull instancetype) initWithBytes:(nonnull const void *) value objCType:(nonnull const char *) type {
	self = [super init];
	if (self) {
		NSParameterAssert(value);
		NSParameterAssert(type);
		_number.setWithBytesAndObjCType(value, type);
	}
	return self;
}

- (nullable instancetype) initWithCoder:(nullable NSCoder *) decoder {
	self = [super init];
	if (self) {
		if (decoder) {
			const size_t size1 = sizeof(_number.data);
			const size_t size2 = sizeof(_number.serviceInfo);
			NSUInteger len = 0;
			const uint8_t * bytes = [decoder decodeBytesForKey:@"b" returnedLength:&len];
			if (bytes && len == (size1 + size2)) {
				memcpy(&_number.data, bytes, size1);
				memcpy(&_number.serviceInfo, &bytes[size1], size2);
				return self;
			}
		}
	}
	return nil;
}

#pragma mark - NSObject init
- (nonnull instancetype) init {
	self = [super init];
	if (self) _number.set<int>(0, NSMNumberValueTypeI);
	return self;
}

- (Class) classForCoder {
	return [NSMutableNumber class];
}

- (Class) classForKeyedArchiver {
	return [NSMutableNumber class];
}

- (id) copy {
	return [self copyWithZone:nil];
}

- (id) mutableCopy {
	_number.lock();
	NSMutableNumber * number = [[NSMutableNumber alloc] init];
	_number.copyDataToNumber(&number->_number);
	_number.unlock();
	return number;
}

- (nonnull NSNumber *) immutableCopy {
	NSNumber * immutableNumber = nil;
	_number.lock();
	if (_number.isUnsigned()) {
		if (_number.reserved[0] == sizeof(unsigned char)) immutableNumber = [[NSNumber alloc] initWithUnsignedChar:_number.get<unsigned char>()];
		else if (_number.reserved[0] == sizeof(unsigned short)) immutableNumber = [[NSNumber alloc] initWithUnsignedShort:_number.get<unsigned short>()];
		else if (_number.reserved[0] == sizeof(unsigned int)) immutableNumber = [[NSNumber alloc] initWithUnsignedInt:_number.get<unsigned int>()];
		else immutableNumber = [[NSNumber alloc] initWithUnsignedLongLong:_number.get<unsigned long long>()];
	} else if (_number.isReal()) {
		if (_number.reserved[0] == sizeof(float)) immutableNumber = [[NSNumber alloc] initWithFloat:_number.get<float>()];
		else immutableNumber = [[NSNumber alloc] initWithDouble:_number.get<double>()];
	} else {
		if (_number.reserved[0] == sizeof(char)) immutableNumber = [[NSNumber alloc] initWithChar:_number.get<char>()];
		else if (_number.reserved[0] == sizeof(short)) immutableNumber = [[NSNumber alloc] initWithShort:_number.get<short>()];
		else if (_number.reserved[0] == sizeof(int)) immutableNumber = [[NSNumber alloc] initWithInt:_number.get<int>()];
		else immutableNumber = [[NSNumber alloc] initWithLongLong:_number.get<long long>()];
	}
	_number.unlock();
	return immutableNumber;
}

- (BOOL) isKindOfClass:(Class) aClass {
	return (aClass == [NSNumber class] || aClass == [NSValue class]) ? YES : [super isKindOfClass:aClass];
}

#pragma mark - NSMutableNumber initializers
- (nonnull NSMutableNumber *) initWithChar:(char) value {
	self = [super init];
	if (self) _number.set<char>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedChar:(unsigned char) value {
	self = [super init];
	if (self) _number.set<unsigned char>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithShort:(short) value {
	self = [super init];
	if (self) _number.set<short>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedShort:(unsigned short) value {
	self = [super init];
	if (self) _number.set<unsigned short>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithInt:(int) value {
	self = [super init];
	if (self) _number.set<int>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedInt:(unsigned int) value {
	self = [super init];
	if (self) _number.set<unsigned int>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithLong:(long) value {
	self = [super init];
	if (self) _number.set<long>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedLong:(unsigned long) value {
	self = [super init];
	if (self) _number.set<unsigned long>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithLongLong:(long long) value {
	self = [super init];
	if (self) _number.set<long long>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedLongLong:(unsigned long long) value {
	self = [super init];
	if (self) _number.set<unsigned long long>(value, NSMNumberValueTypeU);
	return self;
}

- (nonnull NSMutableNumber *) initWithFloat:(float) value {
	self = [super init];
	if (self) _number.set<float>(value, NSMNumberValueTypeR);
	return self;
}

- (nonnull NSMutableNumber *) initWithDouble:(double) value {
	self = [super init];
	if (self) _number.set<double>(value, NSMNumberValueTypeR);
	return self;
}

- (nonnull NSMutableNumber *) initWithBool:(BOOL) value {
	self = [super init];
	if (self) _number.set<char>(value ? (char)1 : (char)0, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithInteger:(NSInteger) value {
	self = [super init];
	if (self) _number.set<NSInteger>(value, NSMNumberValueTypeI);
	return self;
}

- (nonnull NSMutableNumber *) initWithUnsignedInteger:(NSUInteger) value {
	self = [super init];
	if (self) _number.set<NSUInteger>(value, NSMNumberValueTypeU);
	return self;
}

#pragma mark - NSMutableNumber typed getters & setters
- (char) charValue {
	return _number.get<char>();
}

- (void) setCharValue:(char) value {
	_number.set<char>(value, NSMNumberValueTypeI);
}

- (unsigned char) unsignedCharValue {
	return _number.get<unsigned char>();
}

- (void) setUnsignedCharValue:(unsigned char) value {
	_number.set<unsigned char>(value, NSMNumberValueTypeU);
}

- (short) shortValue {
	return _number.get<short>();
}

- (void) setShortValue:(short) value {
	_number.set<short>(value, NSMNumberValueTypeI);
}

- (unsigned short) unsignedShortValue {
	return _number.get<unsigned short>();
}

- (void) setUnsignedShortValue:(unsigned short) value {
	_number.set<unsigned short>(value, NSMNumberValueTypeU);
}

- (int) intValue {
	return _number.get<int>();
}

- (void) setIntValue:(int) value {
	_number.set<int>(value, NSMNumberValueTypeI);
}

- (unsigned int) unsignedIntValue {
	return _number.get<unsigned int>();
}

- (void) setUnsignedIntValue:(unsigned int) value {
	_number.set<unsigned int>(value, NSMNumberValueTypeU);
}

- (long) longValue {
	return _number.get<long>();
}

- (void) setLongValue:(long) value {
	_number.set<long>(value, NSMNumberValueTypeI);
}

- (unsigned long) unsignedLongValue {
	return _number.get<unsigned long>();
}

- (void) setUnsignedLongValue:(unsigned long) value {
	_number.set<unsigned long>(value, NSMNumberValueTypeU);
}

- (long long) longLongValue {
	return _number.get<long long>();
}

- (void) setLongLongValue:(long long) value {
	_number.set<long long>(value, NSMNumberValueTypeI);
}

- (unsigned long long) unsignedLongLongValue {
	return _number.get<unsigned long long>();
}

- (void) setUnsignedLongLongValue:(unsigned long long) value {
	_number.set<unsigned long long>(value, NSMNumberValueTypeU);
}

- (float) floatValue {
	return _number.get<float>();
}

- (void) setFloatValue:(float) value {
	_number.set<float>(value, NSMNumberValueTypeR);
}

- (double) doubleValue {
	return _number.get<double>();
}

- (void) setDoubleValue:(double) value {
	_number.set<double>(value, NSMNumberValueTypeR);
}

- (BOOL) boolValue {
	return (_number.get<long long>() == 0) ? NO : YES;
}

- (void) setBoolValue:(BOOL) value {
	_number.set<char>(value ? (char)1 : (char)0, NSMNumberValueTypeI);
}

- (NSInteger) integerValue {
	return _number.get<NSInteger>();
}

- (void) setIntegerValue:(NSInteger) value {
	_number.set<NSInteger>(value, NSMNumberValueTypeI);
}

- (NSUInteger) unsignedIntegerValue {
	return _number.get<NSUInteger>();
}

- (void) setUnsignedIntegerValue:(NSUInteger) value {
	_number.set<NSUInteger>(value, NSMNumberValueTypeU);
}

- (NSString * _Nonnull) stringValue {
	char buff[44];
	_number.copyToString(buff, 44);
	return [NSString stringWithUTF8String:buff];
}

- (NSComparisonResult) compareWithSigned:(nullable id) otherNumber {
	const long long right = [otherNumber longLongValue];
	if (_number.isUnsigned()) {
		if (right < 0) return NSOrderedDescending; // right is negative, while self is positive
		const unsigned long long left = _number.get<unsigned long long>();
		if (left == right) return NSOrderedSame;
		else if (left < right) return NSOrderedAscending;
	} else {
		const long long left = _number.get<long long>();
		if (left == right) return NSOrderedSame;
		else if (left < right) return NSOrderedAscending;
	}
	return NSOrderedDescending;
}

- (NSComparisonResult) compareWithUnsigned:(nullable id) otherNumber {
	const unsigned long long right = [otherNumber unsignedLongLongValue];
	if (_number.isUnsigned()) {
		const unsigned long long left = _number.get<unsigned long long>();
		if (left == right) return NSOrderedSame;
		else if (left < right) return NSOrderedAscending;
	} else {
		const long long left = _number.get<long long>();
		if (left < 0) return NSOrderedAscending; // self is negative, while right is positive
		if (right == left) return NSOrderedSame;
		else if (right > left) return NSOrderedAscending;
	}
	return NSOrderedDescending;
}

- (NSComparisonResult) compareWithReal:(nullable id) otherNumber {
	const double left = _number.get<double>();
	const double right = [otherNumber doubleValue];
	if (left == right) return NSOrderedSame;
	else if (left < right) return NSOrderedAscending;
	return NSOrderedDescending;
}

- (NSComparisonResult) compare:(nullable id) object {
	NSComparisonResult r = NSOrderedDescending; // left operand is greater than the right(nil or unsupported)
	_number.lock();
	if (object && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSMutableNumber class]])) {
		const NSUInteger type = NSMNumberCTypeFromEncoded([object objCType]);
		if (NSMNumberCTypeIsUnsigned(type)) r = [self compareWithUnsigned:object];
		else if (NSMNumberCTypeIsReal(type)) r = [self compareWithReal:object];
		else r = [self compareWithSigned:object];
	}
	_number.unlock();
	return r;
}

- (BOOL) isEqualToNumber:(nullable id) number {
	return ([self compare:number] == NSOrderedSame);
}

- (BOOL) isEqual:(id) object {
	return ([self compare:object] == NSOrderedSame);
}

- (nonnull NSString *) descriptionWithLocale:(nullable id) locale {
	return self.stringValue;
}

- (NSString *) debugDescription {
	return self.stringValue;
}

- (NSString *) description {
	return self.stringValue;
}

- (NSUInteger) hash {
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

- (id) mutableCopy {
	uint8_t value[32];
	[self getValue:value];
	return [[NSMutableNumber alloc] initWithBytes:value objCType:[self objCType]];
}

@end
