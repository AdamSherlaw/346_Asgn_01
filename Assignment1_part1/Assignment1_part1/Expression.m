//
//  Expression.m
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
//

#import "Expression.h"
#import "Tokens.h"


@implementation Prog

// for rules that only have choices as their production, can default to using
// the GrammarRule parse. But to do that, must add rules to the subrule array.

// Prog -> Expression | Epsilon
// Note how the Prog rule only has optional parts. This is where the GrammarRule
// parse can be used.
-(id)init
{
    self = [super init];
    
    // initalise a new expression
    Expression *expr = [[Expression alloc] init];
    
    // Add expression to the list of rules
    [self addRule:expr];
    
    // Add epsilon to the list of rules
    [self addRule:[Epsilon theEpsilon]];
    return self;
}
@end


// Expression -> Number TailExpr
// In this case, we need to redefine parse
@implementation Expression

-(NSString *) parse:(NSString *)input
{
    NSLog(@"Here expression\n");
    Number *num = [[Number alloc] init];
    NSString *s1 = [num parse:input];
    
    // if we can't parse a number, then the production doesn't match. Return nil.
    if (s1 == nil) return s1;
    
    TailExpr *tail = [[TailExpr alloc] init];
    NSString *s2 = [tail parse:s1];
    
    // set the value of the expression
    if (s2 != nil)
        [self setValue: [num value]+[tail value]];
    return s2;
}

@end



// TailExpr -> + Number tailExpr | Epsilon
// Parse by rules like in prog
@implementation TailExpr


-(NSString *)parse:input
{
    NSLog(@"Tail Expr");
    
    // Retrieve the literal value
    Literal *plus = [[Literal alloc]init: @"+"];
    NSString *s1 = [plus parse: input];
    
    // if we can't parse a '+', then the production doesn't match
    if (s1 == nil) return s1;
    //NSLog(@"Debug s1: %@", s1);
    
    // Parse for the number
    Number *num = [[Number alloc] init];
    NSString *s2 = [num parse: s1];
    
    // If the number exists then
    // set the value of the expression
    if (s2 == nil) return s2;
    //NSLog(@"Debug s2: %@", s2);
    [self setValue: [num value]];
    
    // Parse for tail expression or epsilon
    TailExpr *tail = [[TailExpr alloc] init];
    
    
    [self addRule: tail];
    [self addRule: [Epsilon theEpsilon]];
    
    NSString *s3 = [super parse: s2];
    if (s3 != nil) [self setValue: [tail value] + [num value]];
    //NSLog(@"Debug s3: %@", s3);
    
    return s3;
}

@end

