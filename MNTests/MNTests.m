

#import <XCTest/XCTest.h>
#import "NSMutableNumber.h"

@interface MNTests : XCTestCase

@end

@implementation MNTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testIncDec
{
	NSMutableNumber * mutable = [[NSMutableNumber alloc] initWithInt:0];
	XCTAssertNotNil(mutable);

	mutable.intValue++;
	XCTAssertEqual(mutable.intValue, 1);
	XCTAssertEqual(mutable.unsignedLongLongValue, 1);
	XCTAssertEqual(mutable.boolValue, YES);

	mutable.intValue--;
	XCTAssertEqual(mutable.intValue, 0);
	XCTAssertEqual(mutable.unsignedIntValue, 0);
	XCTAssertEqual(mutable.boolValue, NO);

	mutable.intValue--;
	XCTAssertEqual(mutable.intValue, -1);
	XCTAssertEqual(mutable.charValue, -1);
}

- (void) testEqualMixedTypes
{
	XCTAssertEqualObjects([NSMutableNumber numberWithBool:NO], [NSNumber numberWithChar:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithChar:CHAR_MIN], [NSNumber numberWithInteger:CHAR_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInt:INT_MIN], [NSNumber numberWithLongLong:INT_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInteger:NSIntegerMin], [NSNumber numberWithLongLong:NSIntegerMin]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLong:LONG_MIN], [NSNumber numberWithLongLong:LONG_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLongLong:LONG_LONG_MIN], [NSNumber numberWithLongLong:LONG_LONG_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithShort:SHRT_MIN], [NSNumber numberWithInt:SHRT_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedChar:0], [NSNumber numberWithLong:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInt:0], [NSNumber numberWithInt:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInteger:0], [NSNumber numberWithUnsignedLongLong:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLong:0], [NSNumber numberWithShort:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLongLong:0], [NSNumber numberWithChar:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedShort:0], [NSNumber numberWithShort:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithBool:YES], [NSNumber numberWithFloat:1]);
	XCTAssertEqualObjects([NSMutableNumber numberWithChar:CHAR_MAX], [NSNumber numberWithUnsignedChar:CHAR_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInt:INT_MAX], [NSNumber numberWithUnsignedInt:INT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInteger:NSIntegerMax], [NSNumber numberWithUnsignedLongLong:NSIntegerMax]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLong:LONG_MAX], [NSNumber numberWithUnsignedLong:LONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLongLong:LONG_LONG_MAX], [NSNumber numberWithUnsignedLongLong:LONG_LONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithShort:SHRT_MAX], [NSNumber numberWithInt:SHRT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedChar:UCHAR_MAX], [NSNumber numberWithShort:UCHAR_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInt:UINT_MAX], [NSNumber numberWithUnsignedLongLong:UINT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInteger:NSUIntegerMax], [NSNumber numberWithUnsignedLongLong:NSUIntegerMax]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedShort:USHRT_MAX], [NSNumber numberWithInt:USHRT_MAX]);
}

- (void) testEqualNumbersMinRange
{
	XCTAssertEqualObjects([NSMutableNumber numberWithBool:NO], [NSNumber numberWithBool:NO]);
	XCTAssertEqualObjects([NSMutableNumber numberWithChar:CHAR_MIN], [NSNumber numberWithChar:CHAR_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithDouble:DBL_MIN], [NSNumber numberWithDouble:DBL_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithFloat:FLT_MIN], [NSNumber numberWithFloat:FLT_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInt:INT_MIN], [NSNumber numberWithInt:INT_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInteger:NSIntegerMin], [NSNumber numberWithInteger:NSIntegerMin]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLong:LONG_MIN], [NSNumber numberWithLong:LONG_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLongLong:LONG_LONG_MIN], [NSNumber numberWithLongLong:LONG_LONG_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithShort:SHRT_MIN], [NSNumber numberWithShort:SHRT_MIN]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedChar:0], [NSNumber numberWithUnsignedChar:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInt:0], [NSNumber numberWithUnsignedInt:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInteger:0], [NSNumber numberWithUnsignedInteger:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLong:0], [NSNumber numberWithUnsignedLong:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLongLong:0], [NSNumber numberWithUnsignedLongLong:0]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedShort:0], [NSNumber numberWithUnsignedShort:0]);
}

- (void) testEqualNumbersMaxRange
{
	XCTAssertEqualObjects([NSMutableNumber numberWithBool:YES], [NSNumber numberWithBool:YES]);
	XCTAssertEqualObjects([NSMutableNumber numberWithChar:CHAR_MAX], [NSNumber numberWithChar:CHAR_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithDouble:DBL_MAX], [NSNumber numberWithDouble:DBL_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithFloat:FLT_MAX], [NSNumber numberWithFloat:FLT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInt:INT_MAX], [NSNumber numberWithInt:INT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithInteger:NSIntegerMax], [NSNumber numberWithInteger:NSIntegerMax]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLong:LONG_MAX], [NSNumber numberWithLong:LONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithLongLong:LONG_LONG_MAX], [NSNumber numberWithLongLong:LONG_LONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithShort:SHRT_MAX], [NSNumber numberWithShort:SHRT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedChar:UCHAR_MAX], [NSNumber numberWithUnsignedChar:UCHAR_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInt:UINT_MAX], [NSNumber numberWithUnsignedInt:UINT_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedInteger:NSUIntegerMax], [NSNumber numberWithUnsignedInteger:NSUIntegerMax]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLong:ULONG_MAX], [NSNumber numberWithUnsignedLong:ULONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedLongLong:ULONG_LONG_MAX], [NSNumber numberWithUnsignedLongLong:ULONG_LONG_MAX]);
	XCTAssertEqualObjects([NSMutableNumber numberWithUnsignedShort:USHRT_MAX], [NSNumber numberWithUnsignedShort:USHRT_MAX]);
}

- (void) testEqualNumbersUnsigned
{
	NSMutableNumber * mutable = [[NSMutableNumber alloc] initWithInt:1];
	XCTAssertNotNil(mutable);

	XCTAssertEqualObjects(mutable, [NSNumber numberWithBool:YES]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInt:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithChar:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithDouble:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithFloat:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInteger:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLong:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLongLong:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedChar:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedInt:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedLong:1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedShort:1]);
}

- (void) testEqualNumbersSigned
{
	NSMutableNumber * mutable = [[NSMutableNumber alloc] initWithInt:-1];
	XCTAssertNotNil(mutable);

	XCTAssertNotEqualObjects(mutable, [NSNumber numberWithBool:NO]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInt:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithChar:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithDouble:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithFloat:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInteger:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLong:-1]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLongLong:-1]);
	XCTAssertNotEqualObjects(mutable, [NSNumber numberWithUnsignedChar:-1]);
	XCTAssertNotEqualObjects(mutable, [NSNumber numberWithUnsignedInt:-1]);
	XCTAssertNotEqualObjects(mutable, [NSNumber numberWithUnsignedLong:-1]);
	XCTAssertNotEqualObjects(mutable, [NSNumber numberWithUnsignedShort:-1]);
}

- (void) testEqualNumbersByZero
{
	NSMutableNumber * mutable = [[NSMutableNumber alloc] initWithInt:0];
	XCTAssertNotNil(mutable);

	XCTAssertEqualObjects(mutable, [NSNumber numberWithBool:NO]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInt:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithChar:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithDouble:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithFloat:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithInteger:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLong:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithLongLong:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedChar:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedInt:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedLong:0]);
	XCTAssertEqualObjects(mutable, [NSNumber numberWithUnsignedShort:0]);
}

- (void) testUseAsNSNumber
{
	NSNumber * number = (NSNumber *)[[NSMutableNumber alloc] initWithInt:0];
	XCTAssertEqual([number isKindOfClass:[NSNumber class]], YES);

	XCTAssertEqual([number charValue], 0);
	XCTAssertEqual([number unsignedCharValue], 0);
	XCTAssertEqual([number shortValue], 0);
	XCTAssertEqual([number unsignedShortValue], 0);
	XCTAssertEqual([number intValue], 0);
	XCTAssertEqual([number unsignedIntValue], 0);
	XCTAssertEqual([number longValue], 0);
	XCTAssertEqual([number unsignedLongValue], 0);
	XCTAssertEqual([number longLongValue], 0);
	XCTAssertEqual([number unsignedLongLongValue], 0);
	XCTAssertEqual([number floatValue], 0);
	XCTAssertEqual([number doubleValue], 0);
	XCTAssertEqual([number boolValue], 0);
	XCTAssertEqual([number integerValue], 0);
	XCTAssertEqual([number unsignedIntegerValue], 0);
	XCTAssertEqual([[number stringValue] isEqualToString:@"0"], YES);
}

- (void) testIsKindOfClass
{
	NSMutableNumber * mutableNumber = [[NSMutableNumber alloc] init];
	XCTAssertEqual([mutableNumber isKindOfClass:[NSNumber class]], YES);
	XCTAssertEqual([mutableNumber isKindOfClass:[NSMutableNumber class]], YES);

	XCTAssertEqual([[[NSNumber numberWithBool:YES] mutableCopy] isKindOfClass:[NSNumber class]], YES);
	XCTAssertEqual([[[NSNumber numberWithBool:YES] mutableCopy] isKindOfClass:[NSMutableNumber class]], YES);
}

- (void) testEqualToNumber
{
	XCTAssertEqual([[NSNumber numberWithInt:0] isEqualToNumber:(NSNumber *)[NSMutableNumber numberWithInt:0]], YES);
	XCTAssertEqual([[NSNumber numberWithUnsignedLongLong:ULLONG_MAX] isEqualToNumber:(NSNumber *)[NSMutableNumber numberWithUnsignedLongLong:ULLONG_MAX]], YES);
}

- (void) testHash
{
	XCTAssertEqual([[NSNumber numberWithBool:YES] hash], [[NSMutableNumber numberWithBool:YES] hash]);
	XCTAssertEqual([[NSNumber numberWithBool:NO] hash], [[NSMutableNumber numberWithBool:NO] hash]);

	XCTAssertEqual([[NSNumber numberWithUnsignedLongLong:ULLONG_MAX] hash], [[NSMutableNumber numberWithUnsignedLongLong:ULLONG_MAX] hash]);
	XCTAssertEqual([[NSNumber numberWithInt:-1] hash], [[NSMutableNumber numberWithInt:-1] hash]);
	XCTAssertEqual([[NSNumber numberWithInt:2] hash], [[NSMutableNumber numberWithShort:2] hash]);
}

- (void)testExample
{
	NSNumber * n = [[NSNumber alloc] initWithInt:1]; // 1, i
	NSMutableNumber * m = [[NSMutableNumber alloc] initWithInt:1];
	NSLog(@"initWithInt %@, %s", n, n.objCType);
	NSLog(@"initWithInt %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithFloat:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithFloat:1];
	NSLog(@"initWithFloat %@, %s", n, n.objCType);
	NSLog(@"initWithFloat %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithChar:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithChar:1];
	NSLog(@"initWithChar %@, %s", n, n.objCType);
	NSLog(@"initWithChar %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedChar:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedChar:1];
	NSLog(@"initWithUnsignedChar %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedChar %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithShort:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithShort:1];
	NSLog(@"initWithShort %@, %s", n, n.objCType);
	NSLog(@"initWithShort %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedShort:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedShort:1];
	NSLog(@"initWithUnsignedShort %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedShort %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedInt:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedInt:1];
	NSLog(@"initWithUnsignedInt %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedInt %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithLong:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithLong:1];
	NSLog(@"initWithLong %@, %s", n, n.objCType);
	NSLog(@"initWithLong %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedLong:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedLong:1];
	NSLog(@"initWithUnsignedLong %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedLong %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithLongLong:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithLongLong:1];
	NSLog(@"initWithLongLong %@, %s", n, n.objCType);
	NSLog(@"initWithLongLong %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedLongLong:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedLongLong:1];
	NSLog(@"initWithUnsignedLongLong %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedLongLong %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithDouble:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithDouble:1];
	NSLog(@"initWithDouble %@, %s", n, n.objCType);
	NSLog(@"initWithDouble %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithBool:YES]; // 1, f
	m = [[NSMutableNumber alloc] initWithBool:YES];
	NSLog(@"initWithBool %@, %s, [%@]", n, n.objCType, n.stringValue);
	NSLog(@"initWithBool %@, %s, [%@]", m, m.objCType, m.stringValue);

	n = [[NSNumber alloc] initWithInteger:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithInteger:1];
	NSLog(@"initWithInteger %@, %s", n, n.objCType);
	NSLog(@"initWithInteger %@, %s", m, m.objCType);

	n = [[NSNumber alloc] initWithUnsignedInteger:1]; // 1, f
	m = [[NSMutableNumber alloc] initWithUnsignedInteger:1];
	NSLog(@"initWithUnsignedInteger %@, %s", n, n.objCType);
	NSLog(@"initWithUnsignedInteger %@, %s", m, m.objCType);


	n = [[NSNumber alloc] initWithDouble:3.14159346564465]; //
	NSMutableNumber * n1 = [n mutableCopy];
	NSLog(@"%@", n1);

	n1 = [@(8.7654321) mutableCopy];
	NSLog(@"%@", n1);

	NSMutableDictionary * d = [NSMutableDictionary dictionary];
	d[[NSMutableNumber numberWithDouble:3.14]] = @"PI string";
	NSString * val = d[[NSMutableNumber numberWithDouble:3.14]];
	NSLog(@"%@", val);

	NSLog(@"%@", [NSNumber numberWithUnsignedLongLong:ULLONG_MAX]);
	NSLog(@"%@", [NSMutableNumber numberWithUnsignedLongLong:ULLONG_MAX]);
}

- (void) testCreateN
{
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
		{
			NSNumber * n = [[NSNumber alloc] initWithUnsignedInteger:1];
			n = nil;
		}
    }];
}

- (void) testCreateM
{
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
		{
			NSMutableNumber * n = [[NSMutableNumber alloc] initWithUnsignedInteger:1];
			XCTAssert(n);
			n = nil;
		}
	}];
}

- (void) testCompareN
{
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
		{
			NSNumber * n1 = [[NSNumber alloc] initWithUnsignedInteger:1];
			NSNumber * n2 = [[NSNumber alloc] initWithDouble:1];
			XCTAssert(n1);
			XCTAssert(n2);
			XCTAssert([n1 compare:n2] == NSOrderedSame);
		}
	}];
}

- (void) testCompareM
{
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
		{
			NSMutableNumber * n1 = [[NSMutableNumber alloc] initWithUnsignedInteger:1];
			NSMutableNumber * n2 = [[NSMutableNumber alloc] initWithDouble:1];
			XCTAssert(n1);
			XCTAssert(n2);
			XCTAssert([n1 compare:n2] == NSOrderedSame);
		}
	}];
}


@end
