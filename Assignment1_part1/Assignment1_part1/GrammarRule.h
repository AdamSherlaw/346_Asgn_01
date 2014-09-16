//
//  GrammarRule.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//
//  This is the top level object for all grammar rules in the recursive
//  descent parser.
//  Any rule, should be derived from this class.
//

#import <Foundation/Foundation.h>


@interface GrammarRule : NSObject
{
    // The subrules array is for a generic production that only includes
    // non-terminal options.
    NSMutableArray *subrules;
}

// Value is used to store the result of any object or expression (if any)
@property int value;

// Name is used to store the string of an object or id or number (if any)
@property NSString *name;

// Adds the given rule to the array of rules.
// Subclasses would not normally override this method
-(void) addRule: (GrammarRule *)rule;

// init should be overridden if a subclass has an extra member object or
// property, or to add optional non-terminals to the subrules object
-(id) init;

// Parse calls the rules in the rules sub array and consumes any matched input
// and returns the remaining string
//
// Parse should be overridden so that productions with terminals are matched

-(NSString *) parse:(NSString *)input;

@end


// An epsilon rule is one that matches nothing.
@interface Epsilon: GrammarRule

-(NSString *)parse:(NSString*)input;

// Singleton pattern for epsilon
// Only one instance of the epsilon object
+(Epsilon*) theEpsilon;

@end

