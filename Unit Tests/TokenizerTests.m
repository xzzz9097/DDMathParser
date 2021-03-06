//
//  TokenizerTests.m
//  DDMathParser
//
//  Created by Dave DeLong on 11/16/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "TokenizerTests.h"
#import "DDMathTokenizer.h"
#import "DDMathToken.h"

@implementation TokenizerTests

- (void)evaluate:(NSArray *)bits {
	
	DDMathTokenizer * tokenizer = [[DDMathTokenizer alloc] initWithString:[bits componentsJoinedByString:@""]];
	NSArray * tokens = [[tokenizer tokens] valueForKey:@"token"];
	
	XCTAssertTrue([tokens isEqualToArray:bits], @"mismatched tokens.  expected %@, given %@", bits, tokens);
	[tokenizer release];	
}

- (void)testTokenizer {
    
	DDMathTokenizer * tokenizer = [[DDMathTokenizer alloc] initWithString:@"1"];
	NSArray * tokens = [tokenizer tokens];
	
	XCTAssertTrue([tokens count] == 1, @"should have 1 token.  Given: %d", [tokens count]);
	
	DDMathToken * token = [tokens objectAtIndex:0];
	
	XCTAssertNotNil(token, @"token should not be nil");
	XCTAssertEqualObjects([token token], @"1", @"token should be 1.  Given: %@", [token token]);
	XCTAssertTrue([token tokenType] == DDTokenTypeNumber, @"token type should be Number.  Given: %d", [token tokenType]);
	
	[tokenizer release];
    
}

- (void)testTokenizer2 {
	NSArray * expected = [NSArray arrayWithObjects:@"1", @"+", @"2", nil];
	[self evaluate:expected];
}

- (void)testTokenizer3 {
	NSArray * expected = [NSArray arrayWithObjects:@"1", @"+", @"(", @"4", @"*", @"42", @")", nil];
	[self evaluate:expected];
}

- (void)testTokenizer4 {
	NSArray * expected = [NSArray arrayWithObjects:@"1", @"+", @"sin", @"(", @"4", @"*", @"42", @")", nil];
	[self evaluate:expected];
}

- (void)testTokenizer5 {
	NSArray * expected = [NSArray arrayWithObjects:@"sin", @"(", @"sin", @"(", @"sin", @"(", @"sin", @"(", @"e", @"(", @")", @")", @")", @")", @")", nil];
	[self evaluate:expected];
}

- (void)testTokenizer6 {
	NSArray * expected = [NSArray arrayWithObjects:@"10e2", nil];
	[self evaluate:expected];
}

- (void)testTokenizer7 {
	NSArray * expected = [NSArray arrayWithObjects:@"(", @"pi", @"(", @")", @"*", @"42", @")", nil];
	[self evaluate:expected];
}

- (void)testTokenizer8 {
	NSArray * expected = [NSArray arrayWithObjects:@"1", @"<<", @"1", nil];
	[self evaluate:expected];
}

- (void)testTokenizer9 {
	NSArray * expected = [NSArray arrayWithObjects:@"SUBTRACT", @"(", @"ADD", @"(", @"NEGATE", @"(", @"1", @")", @",", @"2", @")", @",", @"ADD", @"(", @"3", @",", @"4", @")", @")", nil];
	[self evaluate:expected];
}

- (void)testTokenizer10 {
	DDMathTokenizer * tokenizer = [[DDMathTokenizer alloc] initWithString:@"3 x 9"];
	NSArray * tokens = [[tokenizer tokens] valueForKey:@"token"];
	NSArray * expected = [NSArray arrayWithObjects:@"3", @"*", @"9", nil];
	XCTAssertEqualObjects(tokens, expected, @"unexpected tokens.  expected: %@, given: %@", expected, tokens);
}

- (void)testInvalidNumber {
	XCTAssertThrows([[[DDMathTokenizer alloc] initWithString:@"10e2e2"] autorelease], @"expected exception, none thrown");
}

@end
