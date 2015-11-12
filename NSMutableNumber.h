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


#import <Foundation/Foundation.h>

@interface NSMutableNumber : NSObject <NSCopying, NSSecureCoding>

@property (nonatomic, assign, readonly) const char * _Nonnull objCType;

- (nonnull instancetype) initWithBytes:(nonnull const void *) value objCType:(nonnull const char *) type;

- (nullable instancetype) initWithCoder:(nullable NSCoder *) decoder;

- (nonnull instancetype) init;

- (nonnull NSMutableNumber *) initWithChar:(char) value;
- (nonnull NSMutableNumber *) initWithUnsignedChar:(unsigned char) value;
- (nonnull NSMutableNumber *) initWithShort:(short) value;
- (nonnull NSMutableNumber *) initWithUnsignedShort:(unsigned short) value;
- (nonnull NSMutableNumber *) initWithInt:(int) value;
- (nonnull NSMutableNumber *) initWithUnsignedInt:(unsigned int) value;
- (nonnull NSMutableNumber *) initWithLong:(long) value;
- (nonnull NSMutableNumber *) initWithUnsignedLong:(unsigned long) value;
- (nonnull NSMutableNumber *) initWithLongLong:(long long) value;
- (nonnull NSMutableNumber *) initWithUnsignedLongLong:(unsigned long long) value;
- (nonnull NSMutableNumber *) initWithFloat:(float) value;
- (nonnull NSMutableNumber *) initWithDouble:(double) value;
- (nonnull NSMutableNumber *) initWithBool:(BOOL) value;
- (nonnull NSMutableNumber *) initWithInteger:(NSInteger) value;
- (nonnull NSMutableNumber *) initWithUnsignedInteger:(NSUInteger) value;

@property (nonatomic, assign, readwrite) char charValue;
@property (nonatomic, assign, readwrite) unsigned char unsignedCharValue;
@property (nonatomic, assign, readwrite) short shortValue;
@property (nonatomic, assign, readwrite) unsigned short unsignedShortValue;
@property (nonatomic, assign, readwrite) int intValue;
@property (nonatomic, assign, readwrite) unsigned int unsignedIntValue;
@property (nonatomic, assign, readwrite) long longValue;
@property (nonatomic, assign, readwrite) unsigned long unsignedLongValue;
@property (nonatomic, assign, readwrite) long long longLongValue;
@property (nonatomic, assign, readwrite) unsigned long long unsignedLongLongValue;
@property (nonatomic, assign, readwrite) float floatValue;
@property (nonatomic, assign, readwrite) double doubleValue;
@property (nonatomic, assign, readwrite) BOOL boolValue;
@property (nonatomic, assign, readwrite) NSInteger integerValue;
@property (nonatomic, assign, readwrite) NSUInteger unsignedIntegerValue;
@property (nonatomic, readonly, copy) NSString * _Nonnull stringValue;

- (void) getValue:(nonnull void *) value;

- (NSComparisonResult) compare:(nullable id) otherNumber;

- (BOOL) isEqualToNumber:(nullable id) number;

- (nonnull NSString *) descriptionWithLocale:(nullable id) locale;

@end

@interface NSMutableNumber(NSMutableNumberCreation)

+ (nonnull NSMutableNumber *) numberWithChar:(char) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedChar:(unsigned char) number;
+ (nonnull NSMutableNumber *) numberWithShort:(short) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedShort:(unsigned short) number;
+ (nonnull NSMutableNumber *) numberWithInt:(int) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedInt:(unsigned int) number;
+ (nonnull NSMutableNumber *) numberWithLong:(long) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedLong:(unsigned long) number;
+ (nonnull NSMutableNumber *) numberWithLongLong:(long long) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedLongLong:(unsigned long long) number;
+ (nonnull NSMutableNumber *) numberWithFloat:(float) number;
+ (nonnull NSMutableNumber *) numberWithDouble:(double) number;
+ (nonnull NSMutableNumber *) numberWithBool:(BOOL) number;
+ (nonnull NSMutableNumber *) numberWithInteger:(NSInteger) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedInteger:(NSUInteger) number;

@end


@interface NSNumber(NSMutableNumberMutableCopy)

@end
