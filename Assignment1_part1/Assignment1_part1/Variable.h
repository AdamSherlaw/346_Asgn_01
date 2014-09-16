//
//  Variable.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//
//  Contains the objects for varaible storage and Variable itself
//

#import <Foundation/Foundation.h>

// Variable rule used as a Variable object to store in the
// variables dictionary.
//
@interface Variable : NSObject

// Value assigned to the variable
@property int value;

// Name is used to store the name of the variable
@property NSString *name;


-(id) init;


@end

// Storage of variables in a dictionary
@interface VarStore:NSObject
{
    NSMutableDictionary *variables;
}

-(id) init;
// Singleton pattern
+(VarStore *) VariableDict;

// Add the given Variable into the varaibales dictionary
-(void) addVariable:(Variable *)variable;

// Returns the dictionary containing the variables
-(NSMutableDictionary *)getDictionary;

@end


