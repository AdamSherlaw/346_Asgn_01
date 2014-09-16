//
//  Expression.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//

#import "Expression.h"
#import "Tokens.h"


@implementation Prog

-(id)init
{
    self = [super init];
    
    // Add Print to the list of rules
    [self addRule: [[Print alloc] init]];
    
    // Add Assign to the list of rules
    [self addRule:[[Assign alloc] init]];
    
    // Add epsilon to the list of rules
    [self addRule:[Epsilon theEpsilon]];
    
    return self;
}
@end




@implementation Print

-(NSString *) parse:input
{
    // Parse for a print statement
    NSString *s1 = [[[Literal alloc] init: @"print"] parse:input];
    
    if (s1 == nil) return s1;
    
    // Parse for an Expression
    Expression *expr = [[Expression alloc] init];
    NSString *s2 = [expr parse:s1];
    
    if (s2 == nil) return s2;
    printf(">>> %d\n", [expr value]);
    
    // Parse the remainder (s2) of the input
    return [[[Prog alloc] init] parse: s2];
}

@end



@implementation Expression

-(NSString *) parse:(NSString *)input
{
    // Parse for a MulTerm
    MulTerm *multerm = [[MulTerm alloc] init];
    NSString *s1 = [multerm parse:input];
    
    if (s1 == nil) return s1;
    [self setValue: [multerm value]];
    
    // Parse for ExprTail
    ExprTail *tail = [[ExprTail alloc] init];
    NSString *s2 = [tail parse:s1];
    
    if (s2 == nil) return s1;
    [self setValue:[multerm value] + [tail value]];
    
    return s2;
}

@end



@implementation MulTerm

-(NSString *)parse:input
{
    // Parse for a Value
    Value *val = [[Value alloc] init];
    NSString *s1 = [val parse:input];
    
    if (s1 == nil) return s1;
    
    [self setValue:[val value]];
    
    // Parse for a MulTail
    MulTail *multail = [[MulTail alloc] init];
    NSString *s2 = [multail parse:s1];
    
    if (s2 == nil) return s1;
    
    [self setValue:[val value] * [multail value]];
    return s2;
}

@end



@implementation MulTail

-(NSString *)parse:input
{
    // Parse the SubMulTail
    SubMulTail *sub = [[SubMulTail alloc] init];
    NSString *s1 = [sub parse:input];
    
    if (s1 == nil) return s1;
    
    [self setValue:[sub value]];
    
    return [[[Epsilon alloc] init] parse:s1];
}

@end



@implementation SubMulTail

-(NSString *) parse:input
{
    // Parse for '*' literal
    NSString *s1 = [[[Literal alloc] init: @"*"] parse:input];
    
    if (s1 == nil) return s1;
    
    // Parse for a Value
    Value *val = [[Value alloc] init];
    NSString *s2 = [val parse: s1];
    
    if (s2 == nil) return s2;
    [self setValue: [val value]];
    
    // Parse for Multail
    MulTail *multail = [[MulTail alloc] init];
    NSString *s3 = [multail parse: s2];
    
    if (s3 == nil) return s2;
    [self setValue: [val value] * [multail value]];
    return s3;
}

@end



@implementation ExprTail

-(NSString *)parse:input
{
    [self addRule:[[SubExprTail alloc] init]];
    [self addRule:[[Epsilon alloc] init]];
    return [super parse:input];
}

@end



@implementation SubExprTail

-(NSString *) parse:input
{
    // Parse the set + or -
    NSString *s1 = [[[OperatorSet alloc]init: @"[+|-]"] parse: input];
    if (s1 == nil) return s1;
    
    // Parse for the multerm
    MulTerm *multerm = [[MulTerm alloc] init];
    NSString *s2 = [multerm parse: s1];
    
    if (s2 == nil) return s2;
    [self setValue: [multerm value]];
    
    // Parse for tail expression
    ExprTail *tail = [[ExprTail alloc] init];
    NSString *s3 = [tail parse: s2];
    
    if (s3 == nil) return s2;
    
    // Parse for literal
    if ([[[Literal alloc]init:@"+"] parse: input] != nil)
        [self setValue: [multerm value] + [tail value]];
    else
        [self setValue: -[multerm value] + [tail value]];
    return s3;
}

@end



@implementation Assign

-(NSString *)parse:(NSString *)input
{
    // Create Variable Object to store
    Variable *var = [[Variable alloc] init];
    
    // Parse for a variable name
    OperatorSet *varName = [[OperatorSet alloc] init:@"[a-z]+[0-9]*"];
    NSString *s1 = [varName parse:input];
    [var setName:[varName name]];
    
    if (s1 == nil) return s1;
    
    // Parse for a literal =
    NSString *s2 = [[[Literal alloc] init:@"="] parse: s1];
    
    if (s2 == nil) return s2;
    
    // Parse for Expression
    Expression *expr = [[Expression alloc] init];
    NSString *s3 = [expr parse: s2];
    
    if (s3 == nil) return s2;
    
    // Set the value of the variable
    [var setValue:[expr value]];
    
    // Store the variable in the variable dictionary
    [[VarStore VariableDict] addVariable:var];
    
    // Parse for Program
    return [[[Prog alloc] init] parse:s3];
}

@end



@implementation Value

-(NSString *)parse:(NSString *)input
{
    // Parse for varaiable name
    OperatorSet *varName = [[OperatorSet alloc] init:@"[a-z]+[0-9]*"];
    NSString *s1 = [varName parse: input];
    
    if (s1 != nil) {
        // Retrieve the dictionary
        NSMutableDictionary *dict = [[VarStore VariableDict] getDictionary];
        
        // Find the varaible
        Variable *temp = dict[[varName name]];
        
        // Retrieve the variable value
        if (temp != nil) [self setValue:[temp value]];
        return s1;
    }
    
    // Parse for a number
    Number *num = [[Number alloc] init];
    NSString *s2 = [num parse:input];
    
    if (s2 != nil) [self setValue:[num value]];
    return s2;
}

@end
