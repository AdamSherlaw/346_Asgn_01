//
//  Expression.h
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
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



