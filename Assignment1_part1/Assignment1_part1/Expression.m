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


// Expression -> Number ExprTail
// In this case, we need to redefine parse
@implementation Expression

-(NSString *) parse:(NSString *)input
{
    NSLog(@"Expression");
    
    // Parse for a MulTerm
    MulTerm *multerm = [[MulTerm alloc] init];
    NSString *s1 = [multerm parse:input];
    
    if (s1 == nil) return s1;
    NSLog(@"Multerm Value: %d", [multerm value]);
    [self setValue: [multerm value]];
    
    // Parse for ExprTail
    ExprTail *tail = [[ExprTail alloc] init];
    NSString *s2 = [tail parse:s1];
    //NSLog(@"Debug s2: %@", s2);
    if (s2 == nil) return s1;
    
    NSLog(@"\nExpr: Multerm: %d Tail: %d", [multerm value], [tail value]);
    [self setValue:[multerm value] + [tail value]];
    
    return s2;
}

@end


// MulTerm -> Number Multail
@implementation MulTerm

-(NSString *)parse:input
{
    NSLog(@"Multerm");
    // Parse Number
    Number *num = [[Number alloc] init];
    NSString *s1 = [num parse:input];
    
    if (s1 == nil) return s1;
    
    [self setValue:[num value]];
    
    // MulTail
    MulTail *multail = [[MulTail alloc] init];
    NSString *s2 = [multail parse:s1];
    
    if (s2 != nil) {
        NSLog(@"Values: Number: %d MulTail: %d", [num value], [multail value]);
        [self setValue:[num value] * [multail value]];
        return s2;
    }
    
    return s1;
}

@end


// MulTail -> * Number Multail | Epsilon
@implementation MulTail

-(NSString *)parse:input
{
    NSLog(@"Multail");
    
    SubMulTail *sub = [[SubMulTail alloc] init];
    NSString *s1 = [sub parse:input];
    
    // if sub parse was a success
    if (s1 != nil) {
        NSLog(@"SubMulTail return: %d", [sub value]);
        [self setValue:[sub value]];
        return s1;
    }
    
    Epsilon *eps = [[Epsilon alloc] init];
    NSString *s2 = [eps parse:s1];
    
    return s2;
}

@end


@implementation SubMulTail

-(NSString *) parse:input
{
    NSLog(@"SubMulTail");
    // Parse for *
    Literal *mult = [[Literal alloc] init: @"*"];
    NSString *s1 = [mult parse:input];
    
    if (s1 == nil) return s1;
    
    // Parse for number
    Number *num = [[Number alloc] init];
    NSString *s2 = [num parse:s1];
   
    if (s2 == nil) return s2;
    
    [self setValue: [num value]];
    
    // Parse for Multail
    MulTail *multail = [[MulTail alloc] init];
    
    NSString *s3 = [multail parse: s2];
    
    if (s3 != nil) {
        
        [self setValue: [num value] * [multail value]];
        NSLog(@"SubMulTail: Num Value: %d Multail Number: %d", [num value], [multail value]);
        return s3;
    }
    
    return s2;
}

@end



//  ExprTail -> + MulTerm  | Epsilon

// ExprTail -> + Number ExprTail | Epsilon
// Parse by rules like in prog
@implementation ExprTail


-(NSString *)parse:input
{
    NSLog(@"ExprTail");
    
    SubExprTail *sub = [[SubExprTail alloc] init];
    NSString *s1 = [sub parse:input];
    
    if (s1 != nil) {
        NSLog(@"SubExprTail return: %d", [sub value]);
        [self setValue: [sub value]];
        return s1;
    }
    
    NSLog(@"here");
    Epsilon *eps = [[Epsilon alloc] init];
    NSString *s2 = [eps parse:s1];
    
    return s2;
}

@end

@implementation SubExprTail

-(NSString *) parse:input
{
    NSLog(@"SubExprTail");
    // Retrieve the literal value
    Literal *plus = [[Literal alloc]init: @"+"];
    NSString *s1 = [plus parse: input];
    
    // if we can't parse a '+', then the production doesn't match
    if (s1 == nil) return s1;
    
    // Parse for the multerm
    MulTerm *multerm = [[MulTerm alloc] init];
    NSString *s2 = [multerm parse: s1];
    
    // If the multerm exists then
    // set the value of the expression
    if (s2 == nil) return s2;
    
    [self setValue: [multerm value]];
    
    // Parse for tail expression
    ExprTail *tail = [[ExprTail alloc] init];
    NSString *s3 = [tail parse: s2];
    
    if (s3 != nil) {
        NSLog(@"Tail Value: %d Multerm value: %d", [tail value], [multerm value]);
        [self setValue: [tail value] + [multerm value]];
        return s3;
    }
    
    return s2;
}

@end



