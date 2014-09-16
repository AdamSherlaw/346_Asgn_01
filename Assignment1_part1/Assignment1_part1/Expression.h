//
//  Expression.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//

#import <Foundation/Foundation.h>
#import "GrammarRule.h"
#import "Variable.h"

// Grammar is as follows:
//
// Prog     -> Print | Assign | Epsilon
// Print    -> print Expr Prog
// Assign   -> Id = Expr Prog
// Expr     -> MulTerm Exprtail
// Exprtail -> +|- MulTerm Exprtail | Epsilon
// MulTerm  -> Value Multail
// Multail  -> * Value Multail | Epsilon
// Value    -> Id | Number
//

//
// Prog Rule: Print rule or Epsilon rule
// Returns input string minus the consumed rules
//
@interface Prog: GrammarRule

-(id) init;

@end

//
// Print Rule: 'print' statement followed by an Expression rule followed
// by a program rule.
// Returns nil if print statement not found, Expression not found or program
// not found.
// Returns input string minus the consumed rules
//
@interface Print: GrammarRule

-(NSString *) parse:(NSString *)input;

@end

//
// Expression Rule: Multiplication Term rule followed by an Expression Tail
// rule
// Returns nil if Multiplication Term or Expression Tail are not found.
// Returns input string minus the consumed rules
//
@interface Expression : GrammarRule

-(NSString *) parse:(NSString *)input;

@end

//
// Multiplication Rule: Value rule followed by a multiplication Tail rule
// Retruns nil if value or multiplication term not found
// Returns input string minus the consumed rules
//
@interface MulTerm : GrammarRule

-(NSString *) parse: (NSString *)input;

@end

//
// Multiplication Tail Rule: Sub Multiplication Tail rule | Epsilon rule
// Retruns nil of Sub Multiplication Rule Tail rule not found
// Returns input string minus the consumed rules
//
@interface MulTail : GrammarRule

-(NSString *) parse: (NSString *)input;

@end

//
// Sub Multiplication Tail Rule: '*' followed by Value rule followed by
// Multiplication tail rule
// Returns nil if literal, value or tail not found
// Returns input string minus the consumed rules
//
@interface SubMulTail : MulTail

-(NSString *) parse: (NSString *)input;

@end

//
// Expression Tail Rule: Sub Expression Tail Rule | Epsilon
// Returns nil if sub Expression Tail Rule not found
// Returns input string minus the consumed rules
//
@interface ExprTail: GrammarRule

-(NSString *) parse:(NSString *)input;

@end

//
// SubExpressionTail -> '+'|'-' MultiplicationTerm ExpressionTail
// Sub Expression Tail Rule: literal '+' or '-' followed by Multiplication
// Term followed by an Expression Tail Rule.
//
// Returns nil if literal, Multiplication Term Rule or Expression Rule not
// found.
// Returns input string minus the consumed rules
//
@interface SubExprTail: ExprTail

-(NSString *) parse:(NSString *)input;

@end


//
// Assign Rule: Id name followed by a literal '=' followed by an Expression
// followed by a Program rule
//
// Assigns the expression value to the varaible name.
// Returns input string minus the consumed rules
//
@interface Assign: GrammarRule

-(NSString *)parse:(NSString *)input;

@end

//
// Value Rule: variable name id or Number rule
//
@interface Value: GrammarRule

-(NSString *)parse:(NSString *)input;

@end



