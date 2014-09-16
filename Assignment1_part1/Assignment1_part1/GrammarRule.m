//
//  GrammarRule.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//

#import "GrammarRule.h"

@implementation GrammarRule

@synthesize value, name;

-(id) init
{
    self = [super init];
    // Initialize the subrules array
    subrules = [[NSMutableArray alloc] init];
    
    return self;
}


-(void) addRule:(GrammarRule *)rule
{
    // Add the Grammar Rule to the rules array
    [subrules addObject:rule];
}



-(NSString *) parse:(NSString *)input
{
    // For each grammar rule
    for (GrammarRule *rule in subrules)
    {
        NSString *next = [rule parse:input];
        if (next != nil)
        {
            [self setName:[rule name]];
            [self setValue:[rule value]];
            return next;
        }
    }
    return nil;
}

@end



@implementation Epsilon

-(NSString *) parse:(NSString *)input
{
    // always succeeds. Doesn't consume anything
    return input;
}

+(Epsilon *) theEpsilon
{
    static Epsilon *epsilon = nil;
    // Only create one instance of Epsilon object
    if (epsilon == nil)
        epsilon = [[Epsilon alloc] init];
    
    return epsilon;
}

@end

