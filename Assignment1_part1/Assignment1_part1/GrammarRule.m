//
//  GrammarRule.m
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
//

#import "GrammarRule.h"

@implementation GrammarRule

@synthesize value, name;

-(id) init
{
    self = [super init];
    subrules = [[NSMutableArray alloc] init];
    
    return self;
}


-(void) addRule:(GrammarRule *)rule
{
    [subrules addObject:rule];
}


// the general idea of the parse method is to call any parse methods for
// non-terminals and to match (and consume) a part of the string for terminal
// symbols.
// The parse method should consume some prefix (possibly empty) of the
// string and return the suffix (possibly empty).
-(NSString *) parse:(NSString *)input
{
    NSLog(@"Parsing Grammar Rule %@", input);
    
    // For each grammar rule
    for (GrammarRule *rule in subrules)
    {
        //NSLog(@"LOOPING");
        NSString *next = [rule parse:input];
        if (next != nil)
        {
            [self setName:[rule name]];
            [self setValue:[rule value]];
            //NSLog(@"NEXT %@", next);
            return next;
        }
    }
    return nil;
}


@end



@implementation Epsilon

-(NSString *) parse:(NSString *)input
{
    //NSLog(@"EPSILON PARSE");
    // always succeeds. Doesn't consume anything.
    return input;
}

+(Epsilon *) theEpsilon
{
    
    static Epsilon *epsilon = nil;
    
    if (epsilon == nil)
    {
        epsilon = [[Epsilon alloc] init];
    }
    return epsilon;
}

@end