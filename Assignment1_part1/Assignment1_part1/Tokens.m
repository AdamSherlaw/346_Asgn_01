//
//  Tokens.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//

#import "Tokens.h"


@implementation Token

-(NSString *) parse:(NSString *)input
{
    // Get rid of white space
    input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // The matched token should start at position 0, otherwise it didn't
    // match
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:input options:0 range:NSMakeRange(0, [input length])];
    
    if (NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))||
        (rangeOfFirstMatch.location != 0))
        return nil;
    
    // Set the name of the token based on the string that was matched
    [super setName: [input substringWithRange:rangeOfFirstMatch]];
    
    // Consume the matched part of the string and return the rest
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
    
    // The regular expression is just the passed in literal
    regex = [NSRegularExpression regularExpressionWithPattern:lit options:  NSRegularExpressionIgnoreMetacharacters error:&error];
    
    return self;
}

@end



@implementation OperatorSet

-(id) init:(NSString *)set
{
    self = [super init];
    NSError *error;
    
    // The regular expression is the input set
    regex = [NSRegularExpression regularExpressionWithPattern:set options:  NSRegularExpressionCaseInsensitive error:&error];
    
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
    // First parse the input to find the token
    NSString *res = [super parse:input];
    
    // Then extract the value from the token
    if (res)
        [self setValue:[[self name] intValue]];
    
    return res;
}

@end
