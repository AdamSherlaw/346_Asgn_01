//
//  Tokens.m
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
//

#import "Tokens.h"


@implementation Token

-(NSString *) parse:(NSString *)input
{
    NSLog(@"Parsing token: %@, %@", regex, input);
    // get rid of white space
    input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // the matched token should start at position 0, otherwise it didn't match
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:input options:0 range:NSMakeRange(0, [input length])];
    
    if (NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))||
        (rangeOfFirstMatch.location != 0))
        return nil;
    
    // set the name of the token based on the string that was matched
    [super setName: [input substringWithRange:rangeOfFirstMatch]];
    
    NSLog(@"End Token result: %@", [self name]);
    
    // consume the matched part of the string and return the rest
    unsigned long start = rangeOfFirstMatch.location + rangeOfFirstMatch.length;
    unsigned long reslength = [input length]-start;
    return [input substringWithRange:NSMakeRange(start, reslength)];
}

@end



@implementation Literal

-(id) init:(NSString *)lit
{
    self = [super init];
    NSError *error;
    
    // the regular expression is just the passed in literal
    regex = [NSRegularExpression regularExpressionWithPattern:lit options:  NSRegularExpressionIgnoreMetacharacters error:&error];
    
    return self;
}

@end



@implementation Number

-(id) init
{
    self = [super init];
    NSError *error;
    regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
    
    return self;
}

-(NSString*)parse:(NSString*)input
{
    // first parse the input to find the token
    NSString *res = [super parse:input];
    // then extract the value from the token
    if (res)
        [self setValue:[[self name] intValue]];
    
    NSLog(@"Parse number value: %@, %i", [self name], [self value]);
    return res;
}

@end
