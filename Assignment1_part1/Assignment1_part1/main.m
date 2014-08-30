//
//  main.m
//  COSC346 - Assignment1_part1
//
//  Author: Adam Sherlaw
//  Date: August 2014
//  Skeleton project provided by mccane
//

#import <Foundation/Foundation.h>
#import "GrammarRule.h"
#import "Expression.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        Prog *prog = [[Prog alloc] init];
        
        // Reading the input from file
        NSString *res = [NSString stringWithContentsOfFile:
                         @"/Users/Adam/Documents/Otago_University/Third_Year/Semester02/COSC346/Assignments/Assignment01/OOAsgn01/Assignment1_part1/simple.ex"
                                                  encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"file=%@", res);
        //NSLog(@"%i", [res characterAtIndex:[res length]-1]);
        
        res = [prog parse:res];
    }
    
    return 0;
}


