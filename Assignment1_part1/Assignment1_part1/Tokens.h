//
//  Tokens.h
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrammarRule.h"

// Tokens are essentially for the lexical analysis part of the interpreter.
// In this case a token is still a grammar rule, but it is a rule specified
// by a regular expression rather than an actual rule.
// It's not necessary to do this, but it does make things a bit easier.


// This is the root of the Token part of the hierarchy
@interface Token: GrammarRule
{
    // The sub-classes of Token should initialise the regex variable in their
    // init method
    NSRegularExpression *regex;
}

// The Token class handles the basic parsing of a token. Subclasses can override
// this method, but should call it before doing the subclass relevant parsing.
-(NSString *) parse:(NSString *)input;
@end


// A number is a token
@interface Number: Token

// Initialise the regex variable
-(id) init;

// The parse method needs to set the value of the number (for interpreting)
-(NSString*)parse:(NSString*)input;

@end

// A literal is a token. All literals can use this class by passing in a string.
@interface Literal: Token

-(id) init:(NSString*)lit;

@end
