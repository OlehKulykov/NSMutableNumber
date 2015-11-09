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


/**
 @brief Simple wrapper arrount strong NSNumber object.
 */
@interface NSMutableNumber : NSObject <NSCopying>

@property (nonatomic, assign, readwrite) char charValue;

@property (nonatomic, assign, readwrite) unsigned char unsignedCharValue;

@property (nonatomic, assign, readwrite) short shortValue;

@property (nonatomic, assign, readwrite) unsigned short unsignedShortValue;

@property (nonatomic, assign, readwrite) unsigned int unsignedIntValue;

@property (nonatomic, assign, readwrite) long longValue;

@property (nonatomic, assign, readwrite) unsigned long unsignedLongValue;

@property (nonatomic, assign, readwrite) long long longLongValue;

@property (nonatomic, assign, readwrite) float floatValue;

@property (nonatomic, assign, readwrite) BOOL boolValue;

@property (nonatomic, assign, readwrite) NSInteger integerValue;

@property (nonatomic, assign, readwrite) NSUInteger unsignedIntegerValue;

@property (nonatomic, assign, readwrite) unsigned long long unsignedLongLongValue;

@property (nonatomic, assign, readwrite) int intValue;

@property (nonatomic, assign, readwrite) double doubleValue;

- (nonnull id) initWithUnsignedLongLong:(unsigned long long) number;
+ (nonnull NSMutableNumber *) numberWithUnsignedLongLong:(unsigned long long) number;

- (nonnull id) initWithInt:(int) number;
+ (nonnull NSMutableNumber *) numberWithInt:(int) number;

- (nonnull id) initWithDouble:(double) number;
+ (nonnull NSMutableNumber *) numberWithDouble:(double) number;

+ (nonnull NSMutableNumber *) numberWithChar:(char) number;
- (nonnull id) initWithChar:(char) number;

+ (nonnull NSMutableNumber *) numberWithUnsignedChar:(unsigned char) number;
- (nonnull id) initWithUnsignedChar:(unsigned char) number;

+ (nonnull NSMutableNumber *) numberWithShort:(short) number;
- (nonnull id) initWithShort:(short) number;

+ (nonnull NSMutableNumber *) numberWithUnsignedShort:(unsigned short) number;
- (nonnull id) initWithUnsignedShort:(unsigned short) number;

+ (nonnull NSMutableNumber *) numberWithUnsignedInt:(unsigned int) number;
- (nonnull id) initWithUnsignedInt:(unsigned int) number;

+ (nonnull NSMutableNumber *) numberWithLong:(long) number;
- (nonnull id) initWithLong:(long) number;

+ (nonnull NSMutableNumber *) numberWithUnsignedLong:(unsigned long) number;
- (nonnull id) initWithUnsignedLong:(unsigned long) number;

+ (nonnull NSMutableNumber *) numberWithLongLong:(long long) number;
- (nonnull id) initWithLongLong:(long long) number;

+ (nonnull NSMutableNumber *) numberWithFloat:(float) number;
- (nonnull id) initWithFloat:(float) number;

+ (nonnull NSMutableNumber *) numberWithBool:(BOOL) number;
- (nonnull id) initWithBool:(BOOL) number;

+ (nonnull NSMutableNumber *) numberWithInteger:(NSInteger) number;
- (nonnull id) initWithInteger:(NSInteger) number;

+ (nonnull NSMutableNumber *) numberWithUnsignedInteger:(NSUInteger) number;
- (nonnull id) initWithUnsignedInteger:(NSUInteger) number;

- (NSComparisonResult) compare:(nullable NSNumber *) otherNumber;

- (BOOL) isEqualToNumber:(nullable NSNumber *) number;

- (BOOL) isEqualToMutableNumber:(nullable NSMutableNumber *) number;

@end


@interface NSNumber(NSMutableNumber)

- (nonnull id) mutableCopy;

@end
