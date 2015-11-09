/*
 *   Copyright (c) 2015 Kulykov Oleh <info@resident.name>
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

NSString * const _Nonnull kNSMutableNumberNullString = @"(null)";

@interface NSMutableNumber()

@property (nonatomic, strong) NSNumber * num;

@end

@implementation NSMutableNumber

- (int) intValue
{
	NSNumber * n = self.num;
	return n ? [n intValue] : 0;
}

- (void) setIntValue:(int) value
{
	self.num = [NSNumber numberWithInt:value];
}

- (unsigned long long) unsignedLongLongValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedLongLongValue] : 0;
}

- (void) setUnsignedLongLongValue:(unsigned long long) value
{
	self.num = [NSNumber numberWithUnsignedLongLong:value];
}

- (NSNumber *) numberValue
{
	return self.num;
}

- (void) setNumberValue:(NSNumber *) value
{
	self.num = value;
}

- (double) doubleValue
{
	NSNumber * n = self.num;
	return n ? [n doubleValue] : 0;
}

- (void) setDoubleValue:(double) value
{
	self.num = [NSNumber numberWithDouble:value];
}

- (void) setCharValue:(char) value
{
	self.num = [NSNumber numberWithChar:value];
}

- (char) charValue
{
	NSNumber * n = self.num;
	return n ? [n charValue] : 0;
}

- (void) setUnsignedCharValue:(unsigned char) value
{
	self.num = [NSNumber numberWithUnsignedChar:value];
}

- (unsigned char) unsignedCharValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedCharValue] : 0;
}

- (void) setShortValue:(short) value
{
	self.num = [NSNumber numberWithShort:value];
}

- (short) shortValue
{
	NSNumber * n = self.num;
	return n ? [n shortValue] : 0;
}

- (void) setUnsignedShortValue:(unsigned short) value
{
	self.num = [NSNumber numberWithUnsignedShort:value];
}

- (unsigned short) unsignedShortValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedShortValue] : 0;
}

- (void) setUnsignedIntValue:(unsigned int) value
{
	self.num = [NSNumber numberWithUnsignedInt:value];
}

- (unsigned int) unsignedIntValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedIntValue] : 0;
}

- (void) setLongValue:(long) value
{
	self.num = [NSNumber numberWithLong:value];
}

- (long) longValue
{
	NSNumber * n = self.num;
	return n ? [n longValue] : 0;
}

- (void) setUnsignedLongValue:(unsigned long) value
{
	self.num = [NSNumber numberWithUnsignedLong:value];
}

- (unsigned long) unsignedLongValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedLongValue] : 0;
}

- (void) setLongLongValue:(long long) value
{
	self.num = [NSNumber numberWithLongLong:value];
}

- (long long) longLongValue
{
	NSNumber * n = self.num;
	return n ? [n longLongValue] : 0;
}

- (void) setFloatValue:(float) value
{
	self.num = [NSNumber numberWithFloat:value];
}

- (float) floatValue
{
	NSNumber * n = self.num;
	return n ? [n floatValue] : 0;
}

- (void) setBoolValue:(BOOL) value
{
	self.num = [NSNumber numberWithBool:value];
}

- (BOOL) boolValue
{
	NSNumber * n = self.num;
	return n ? [n boolValue] : NO;
}

- (void) setIntegerValue:(NSInteger) value
{
	self.num = [NSNumber numberWithInteger:value];
}

- (NSInteger) integerValue
{
	NSNumber * n = self.num;
	return n ? [n integerValue] : 0;
}

- (void) setUnsignedIntegerValue:(NSUInteger) value
{
	self.num = [NSNumber numberWithUnsignedInteger:value];
}

- (NSUInteger) unsignedIntegerValue
{
	NSNumber * n = self.num;
	return n ? [n unsignedIntegerValue] : 0;
}

- (NSString * _Nonnull) stringValue
{
	NSNumber * n = self.num;
	return n ? [n stringValue] : kNSMutableNumberNullString;
}

- (nonnull id) initWithUnsignedLongLong:(unsigned long long) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedLongLongValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedLongLong:(unsigned long long) number
{
	return [[NSMutableNumber alloc] initWithUnsignedLongLong:number];
}

- (nonnull id) initWithInt:(int) number
{
	self = [super init];
	if (self) 
	{
		self.intValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithInt:(int) number
{
	return [[NSMutableNumber alloc] initWithInt:number];
}

- (nonnull id) initWithDouble:(double) number
{
	self = [super init];
	if (self) 
	{
		self.doubleValue = number;
	}
	return self;	
}

+ (nonnull NSMutableNumber *) numberWithDouble:(double) number
{
	return [[NSMutableNumber alloc] initWithDouble:number];
}

+ (nonnull NSMutableNumber *) numberWithChar:(char) number
{
	return [[NSMutableNumber alloc] initWithChar:number];
}

- (nonnull id) initWithChar:(char) number
{
	self = [super init];
	if (self) 
	{
		self.charValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedChar:(unsigned char) number
{
	return [[NSMutableNumber alloc] initWithUnsignedChar:number];
}

- (nonnull id) initWithUnsignedChar:(unsigned char) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedCharValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithShort:(short) number
{
	return [[NSMutableNumber alloc] initWithShort:number];
}

- (nonnull id) initWithShort:(short) number
{
	self = [super init];
	if (self) 
	{
		self.shortValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedShort:(unsigned short) number
{
	return [[NSMutableNumber alloc] initWithUnsignedShort:number];
}

- (nonnull id) initWithUnsignedShort:(unsigned short) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedShortValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedInt:(unsigned int) number
{
	return [[NSMutableNumber alloc] initWithUnsignedInt:number];
}

- (nonnull id) initWithUnsignedInt:(unsigned int) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedIntValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithLong:(long) number
{
	return [[NSMutableNumber alloc] initWithLong:number];
}

- (nonnull id) initWithLong:(long) number
{
	self = [super init];
	if (self) 
	{
		self.longValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedLong:(unsigned long) number
{
	return [[NSMutableNumber alloc] initWithUnsignedLong:number];
}

- (nonnull id) initWithUnsignedLong:(unsigned long) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedLongValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithLongLong:(long long) number
{
	return [[NSMutableNumber alloc] initWithLongLong:number];
}

- (nonnull id) initWithLongLong:(long long) number
{
	self = [super init];
	if (self) 
	{
		self.longLongValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithFloat:(float) number
{
	return [[NSMutableNumber alloc] initWithFloat:number];
}

- (nonnull id) initWithFloat:(float) number
{
	self = [super init];
	if (self) 
	{
		self.floatValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithBool:(BOOL) number
{
	return [[NSMutableNumber alloc] initWithBool:number];
}

- (nonnull id) initWithBool:(BOOL) number
{
	self = [super init];
	if (self) 
	{
		self.boolValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithInteger:(NSInteger) number
{
	return [[NSMutableNumber alloc] initWithInteger:number];
}

- (nonnull id) initWithInteger:(NSInteger) number
{
	self = [super init];
	if (self) 
	{
		self.integerValue = number;
	}
	return self;
}

+ (nonnull NSMutableNumber *) numberWithUnsignedInteger:(NSUInteger) number
{
	return [[NSMutableNumber alloc] initWithUnsignedInteger:number];
}

- (nonnull id) initWithUnsignedInteger:(NSUInteger) number
{
	self = [super init];
	if (self) 
	{
		self.unsignedIntegerValue = number;
	}
	return self;
}

- (BOOL) isEqual:(id) object
{
	if (object) 
	{
		NSNumber * n1 = self.num;
		if (n1) 
		{
			NSNumber * n2 = nil;
			
			if ([object isKindOfClass:[NSMutableNumber class]]) 
			{
				n2 = [(NSMutableNumber *)object num];
			}
			else if ([object isKindOfClass:[NSNumber class]])
			{
				n2 = (NSNumber *)object;
			}
			
			return n2 ? [n1 isEqualToNumber:n2] : NO;
		}
	}
	return [super isEqual:object];
}

- (id) copyWithZone:(NSZone *) zone
{
	NSMutableNumber * num = [[NSMutableNumber alloc] init];
	if (self.num) 
	{
		num.num = [self.num copyWithZone:zone];
	}
	return num;
}

- (NSComparisonResult) compare:(nullable NSNumber *) otherNumber
{
	if (otherNumber) 
	{
		NSNumber * n = self.num;
		if (n) return [n compare:otherNumber];
	}
	return NSOrderedSame;
}

- (BOOL) isEqualToNumber:(nullable NSNumber *) number
{
	if (number) 
	{
#if defined(DEBUG) || defined(_DEBUG)
		NSParameterAssert([number isKindOfClass:[NSNumber class]]);
#endif
		NSNumber * n = self.num;
		if (n) return [n isEqualToNumber:number];
	}
	return NO;
}

- (BOOL) isEqualToMutableNumber:(nullable NSMutableNumber *) number
{
#if defined(DEBUG) || defined(_DEBUG)
	if (number)
	{
		NSParameterAssert([number isKindOfClass:[NSMutableNumber class]]);
	}
#endif
	return [self isEqualToNumber:number.num];
}

- (NSString *) description
{
	NSNumber * n = self.num;
	return n ? [n description] : kNSMutableNumberNullString;
}

#if defined(DEBUG) || defined(_DEBUG)
- (NSString *) debugDescription
{
	return [self description];
}
#endif

- (nullable NSString *) descriptionWithLocale:(nullable id) locale
{
	NSNumber * n = self.num;
	return n ? [n descriptionWithLocale:locale] : kNSMutableNumberNullString;
}

@end

@implementation NSNumber(NSMutableNumber)

- (nonnull id) mutableCopy
{
	NSMutableNumber * mutable = [[NSMutableNumber alloc] init];
	assert(mutable);
	mutable.num = [self copy];
	return mutable;
}

@end
