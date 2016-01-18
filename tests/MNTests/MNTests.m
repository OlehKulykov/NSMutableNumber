//
//  MNTests.m
//  MNTests
//
//  Created by Resident evil on 11/11/15.
//  Copyright © 2015 Oleh Kulykov. All rights reserved.
//

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

- (void) testUseAsNSNumber
{
	NSNumber * num = (NSNumber *)[[NSMutableNumber alloc] initWithInt:0];
	XCTAssertEqual([num isKindOfClass:[NSNumber class]], YES);

	XCTAssertEqual([num charValue], 0);
	XCTAssertEqual([num unsignedCharValue], 0);
	XCTAssertEqual([num shortValue], 0);
	XCTAssertEqual([num unsignedShortValue], 0);
	XCTAssertEqual([num intValue], 0);
	XCTAssertEqual([num unsignedIntValue], 0);
	XCTAssertEqual([num longValue], 0);
	XCTAssertEqual([num unsignedLongValue], 0);
	XCTAssertEqual([num longLongValue], 0);
	XCTAssertEqual([num unsignedLongLongValue], 0);
	XCTAssertEqual([num floatValue], 0);
	XCTAssertEqual([num doubleValue], 0);
	XCTAssertEqual([num boolValue], 0);
	XCTAssertEqual([num integerValue], 0);
	XCTAssertEqual([num unsignedIntegerValue], 0);
	XCTAssertEqual([[num stringValue] isEqualToString:@"0"], YES);
}

- (void) testIsKindOfClass
{
	NSMutableNumber * mut = [[NSMutableNumber alloc] init];
	XCTAssertEqual([mut isKindOfClass:[NSNumber class]], YES);
	XCTAssertEqual([mut isKindOfClass:[NSMutableNumber class]], YES);

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
			[n1 compare:n2];
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
			[n1 compare:n2];
		}
	}];
}


@end
