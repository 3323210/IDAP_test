//
//  main.m
//  consoleGame

//  Copyright © 2017  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsolGame.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        ConsolGame *newGame = [[ConsolGame alloc] init];
        
        [newGame startGame];
         
    }
    return 0;
}
