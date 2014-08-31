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

//
// Prog -> Print | Epsilon
//
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


//
//Print -> print Expression Program
//
@implementation Print

-(NSString *) parse:input
{
    // New instance of literal that parses for a print statement
    NSString *s1 = [[[Literal alloc] init: @"print"] parse:input];
    
    if (s1 == nil) return s1;
    
    // Expression
    Expression *expr = [[Expression alloc] init];
    NSString *s2 = [expr parse:s1];

    if (s2 == nil) return s2;
    printf(">>> %d\n", [expr value]);
    
    // New instance of Prog that parses the remainder (s2) of the input
    return [[[Prog alloc] init] parse: s2];
}

@end




//
// Expression -> MultiplicationTerm ExpressionTail
//
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


//
// MultiplicationTerm -> Number MultiplicationTail
//
@implementation MulTerm

-(NSString *)parse:input
{
    //Parse for a Value
    Value *val = [[Value alloc] init];
    NSString *s1 = [val parse:input];
    
    if (s1 == nil) return s1;
    
    [self setValue:[val value]];
    
    // MulTail
    MulTail *multail = [[MulTail alloc] init];
    NSString *s2 = [multail parse:s1];
    
    if (s2 == nil) return s1;
    
    [self setValue:[val value] * [multail value]];
    return s2;
}

@end


//
// MultiplicationTail -> SubMultiplicationTail | Epsilon
//
@implementation MulTail

-(NSString *)parse:input
{
    SubMulTail *sub = [[SubMulTail alloc] init];
    NSString *s1 = [sub parse:input];
    
    // if sub parse fails
    if (s1 == nil) return s1;
    
    [self setValue:[sub value]];
    return [[[Epsilon alloc] init] parse:s1];
}

@end


//
// SubMultiplicationTail -> '*' Number MultiplicationTail
//
@implementation SubMulTail

-(NSString *) parse:input
{
    // Parse for * literal
    NSString *s1 = [[[Literal alloc] init: @"*"] parse:input];
    
    if (s1 == nil) return s1;
   
    // Parse for a value
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



//
// ExpressionTail -> SubExpressionTail | Epsilon
//
@implementation ExprTail

-(NSString *)parse:input
{
    [self addRule:[[SubExprTail alloc] init]];
    [self addRule:[[Epsilon alloc] init]];
    return [super parse:input];
}

@end


//
// SubExpressionTail -> '+' MultiplicationTerm ExpressionTail
//
@implementation SubExprTail

-(NSString *) parse:input
{
    // Retrieve the literal value
    NSString *s1 = [[[Literal alloc]init: @"+"] parse: input];
    
    if (s1 == nil) return s1;
    
    // Parse for the multerm
    MulTerm *multerm = [[MulTerm alloc] init];
    NSString *s2 = [multerm parse: s1];
    
    // Multerm exists, set value
    if (s2 == nil) return s2;
    [self setValue: [multerm value]];
    
    // Parse for tail expression
    ExprTail *tail = [[ExprTail alloc] init];
    NSString *s3 = [tail parse: s2];
    
    if (s3 == nil) return s2;
    
    [self setValue: [tail value] + [multerm value]];
    return s3;
}

@end


@implementation Assign

-(NSString *)parse:(NSString *)input
{
    // Parse for a variable name
    Variable *var = [[Variable alloc] init];
    NSString *s1 = [var parse:input];
    
    if (s1 == nil) return s1;
    
    // Parse for an equals
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
    Variable *varName = [[Variable alloc] init];
    NSString *s1 = [varName parse: input];
    
    if (s1 != nil) {
        NSMutableDictionary *dict = [[VarStore VariableDict] getDictionary];
        Variable *temp = dict[[varName name]];
        
        if (temp != nil) [self setValue:[temp value]];
        return s1;
    }

    Number *num = [[Number alloc] init];
    NSString *s2 = [num parse:input];
    
    if (s2 != nil) [self setValue:[num value]];
    return s2;
}

@end

