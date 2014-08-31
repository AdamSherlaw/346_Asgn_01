//
//  Variable.h
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//

#import <Foundation/Foundation.h>

@interface VarStore:NSObject
{
    NSMutableDictionary *variables;
}

-(id) init;

+(VarStore *) VariableDict;

-(void) addVariable:(id)variable;

-(NSMutableDictionary *)getDictionary;

@end