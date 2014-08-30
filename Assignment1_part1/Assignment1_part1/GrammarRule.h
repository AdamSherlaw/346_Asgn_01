//
//  GrammarRule.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//
//  This is the top level object for all grammar rules in the recursive descent parser. Any rule, should be derived from this class.

#import <Foundation/Foundation.h>

@interface GrammarRule : NSObject
{
    // the subrules array is for a generic production that only includes non-terminal options.
    NSMutableArray *subrules;
}

// value is used to store the result of any object or expression (if any)
@property int value;

// name is used to store the string of an object or id or number (if any).
//The string is the string read from the input file.
@property NSString *name;

// subclasses would not normally override this method
-(void) addRule: (GrammarRule *)rule;

// init should be overridden if a subclass has an extra member object or
//property, or to add optional non-terminals to the subrules object
-(id) init;

// parse should be overridden so that productions with terminals are matched
-(NSString *) parse:(NSString *)input;

@end


// an epsilon rule is one that matches nothing. Very common in gramamrs so it
//makes sense to put it here
@interface Epsilon: GrammarRule

-(NSString *)parse:(NSString*)input;

// singleton pattern
+(Epsilon*) theEpsilon;

@end