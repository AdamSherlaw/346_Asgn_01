//
//  Tokens.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//
//  A token is a grammar rule, but it is a rule specified by a regular
//  expression rather than an actual rule.
//  The parse function consumes the matched portion of the string and returns
//  the remaining string
//

#import <Foundation/Foundation.h>
#import "GrammarRule.h"


// This is the root of the Token part of the hierarchy
//
@interface Token: GrammarRule
{
    // The sub-classes of Token should initialise the regex variable in their
    // init method
    NSRegularExpression *regex;
}

// The Token class handles the basic parsing of a token.
// Subclasses can override this method, but should call it before
// doing the subclass relevant parsing.
-(NSString *) parse:(NSString *)input;

@end


// A number is a token
//
@interface Number: Token

// Initialise the regex variable
-(id) init;

// The parse method needs to set the value of the number (for interpreting)
-(NSString*)parse:(NSString*)input;

@end


// A literal is a token.
// All literals can use this class by passing in a string.
//
@interface Literal: Token

-(id) init:(NSString*)lit;

@end

// An operator set
// Parses for the regex set input string
//
@interface OperatorSet: Token

-(id) init:(NSString*)set;

@end
