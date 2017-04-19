//
//  ConsolGame.h
//  consoleGame 
//
//  Created by Admin on 1/3/17.
//  Copyright © 2017 vl.java. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface ConsolGame : NSObject

@property (strong, nonatomic) NSMutableDictionary* allLocation;
@property (strong, nonatomic) NSMutableDictionary* nextLocation;
@property (strong, nonatomic) NSMutableDictionary* curentLocation;


@property (strong, nonatomic) NSString* userAnswer;

@property (assign, nonatomic) BOOL win;

-(void)startGame;

@end
