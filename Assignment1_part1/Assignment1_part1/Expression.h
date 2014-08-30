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


// This class is currently for very simple expressions - just Number + Number
// Here is the whole grammar

// Prog -> Expression | Epsilon
// Expression -> Number TailExpr
// TailExpr -> + Number

// I'm using this grammar, rather than a simpler one because it shows off the
// basic ideas for the class structure and demonstrates how the recursive
// descent stuff works and how the top-level GrammarRule parse works with
// multiple possible productions.

@interface Prog: GrammarRule

-(id) init;

@end


@interface Print: GrammarRule

-(NSString *) parse:(NSString *)input;

@end


@interface Expression : GrammarRule

-(NSString *) parse:(NSString *)input;

@end


@interface MulTerm : GrammarRule

-(NSString *) parse: (NSString *)input;

@end


@interface MulTail : GrammarRule

-(NSString *) parse: (NSString *)input;

@end


@interface SubMulTail : GrammarRule

-(NSString *) parse: (NSString *)input;

@end


@interface ExprTail: GrammarRule

-(NSString *) parse:(NSString *)input;

@end


@interface SubExprTail: GrammarRule

-(NSString *) parse:(NSString *)input;

@end



