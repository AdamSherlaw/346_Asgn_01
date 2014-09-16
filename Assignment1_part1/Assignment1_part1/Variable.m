//
//  Variable.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//


#import "Variable.h"


@implementation Variable

@synthesize  value, name;

-(id)init
{
    self = [super init];
    return self;
}

@end


@implementation VarStore

-(id)init
{
    self = [super init];
    // Initalise the the dictionary
    variables = [[NSMutableDictionary alloc] init];
    return self;
}


+(VarStore *) VariableDict
{
    static VarStore *var = nil;
    // Initalise only one instance of VaraibleStore
    if (var == nil)
        var = [[VarStore alloc]init];
    
    return var;
}


-(void) addVariable:(Variable *)variable
{
    // Add the given variable to the varaiables dictionary
    // Using the variable name as the key value.
    [variables setObject:variable forKey:[variable name]];
}


-(NSMutableDictionary *)getDictionary
{
    // Return the varaiables dictionary
    return variables;
}

@end





