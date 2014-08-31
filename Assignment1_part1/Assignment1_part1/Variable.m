//
//  Variable.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//


#import "Variable.h"

@implementation VarStore

-(id)init
{
    self = [super init];
    variables = [[NSMutableDictionary alloc] init];
    return self;
}

+(VarStore *) VariableDict
{
    static VarStore *var = nil;
    
    if (var == nil)
        var = [[VarStore alloc]init];
    
    return var;
}

-(void) addVariable:(id)variable
{
    [variables setObject:variable forKey:[variable name]];
}

-(NSMutableDictionary *)getDictionary
{
    return variables;
}

@end
