//
//  main.m
//  Assignment1_part1
//
//  Created by mccane on 7/11/14.
//  Copyright (c) 2014 mccane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrammarRule.h"
#import "Expression.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        Prog *expr = [[Prog alloc] init];
        //MulTail *multail = [[MulTail alloc] init];
        //ExprTail *exprtail = [[ExprTail alloc] init];
        //MulTerm *multerm = [[MulTerm alloc] init];
        //Print *pri = [[Print alloc] init];
        
        // Reading the input from file
        NSString *res = [NSString stringWithContentsOfFile:
                         @"/Users/Adam/Documents/Otago_University/Third_Year/Semester02/COSC346/Assignments/Assignment01/OOAsgn01/Assignment1_part1/simple.ex"
                                                  encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"file=%@", res);
        NSLog(@"%i", [res characterAtIndex:[res length]-1]);
        
        //res = [multail parse:res];
        //res = [exprtail parse:res];
        res = [expr parse:res];
        //res = [multerm parse: res];
        //res = [pri parse:res];
        
        //printf(">>> %d\n", [pri value]);
        //NSLog(@"Parse Error, unparsed: %@", res);
        
        if ([res isEqual:@""])
            // successfully consumed all input
            printf(">>> %d\n", [expr value]);
        else
          NSLog(@"Parse Error, unparsed: %@", res);
        
        }
    
    return 0;
}
    

