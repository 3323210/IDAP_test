//
//  ConsolGame.m
//  consoleGame 

//  Copyright © 2017  All rights reserved.
//

#import "ConsolGame.h"

@implementation ConsolGame
    
    
-(void)startGame {
    
    [self readLocationWithJSON];
    
    if (self.allLocation == nil) {
        return;
    }
    
    NSLog(@"%@ \n",stringStartGame);
    
    [self nextStep];
    
}
    
-(void)endGame {
    
    NSString* stringEndGame = self.win ? stringWin : stringGameOver;
    
    NSLog(@"\n%@",stringEndGame);
    
}
    
-(void)nextStep {
    
    [self setLocations ];
    
    [self showActionAndTitle];
    
    [self getNumUserAnswer];
    
    if (self.nextLocation == nil) {
        
        [self endGame];
        return ;
        
    } else {
        
        [self nextStep];
    }
}
    
#pragma mark - Action
    

-(NSString *) getNumUserAnswer {
    
    char str[3] = {0};                        // init all to 0
    printf("Что вы будете делать: ");
    scanf("%s", str);                         // read and format into the str buffer
   // printf("Your variant is %s\n", str);    // print buffer
   
    //NSUTF8StringEncoding
    NSString * strVariant = [[NSString alloc] initWithCString:str encoding: NSUTF8StringEncoding];
    
    self.userAnswer = strVariant;
    
    NSMutableArray* arrauVariants  = [self availableVariants];
    if ( ![arrauVariants containsObject:self.userAnswer]) {
        printf("Вариант %s не найдено, репит плиз\n",str);
        [self getNumUserAnswer];
    }
    
    printf("\n=================================================== \n");
    
    [self setLocations];
    
    return strVariant;
    
}

-(NSMutableArray *) availableVariants {
    
    NSArray*  arrayAction = [self.curentLocation  objectForKey:@"action"];
    
    NSMutableArray* arrayVariants  = [NSMutableArray array];
    
    for (int i = 1 ; i <= arrayAction.count ; i++) {
       
        [arrayVariants addObject:[NSString stringWithFormat:@"%i",i]];
        
    }
    
    return arrayVariants;
    
}


-(void)showActionAndTitle {
    
    // show title
    
    NSString*  title = [self.curentLocation objectForKey:@"title"];
    
    const char *strTitle = title.UTF8String;
    
    printf("\n%s \n\n", strTitle);
    
    // show picture
    
    NSString*  picture = [self.curentLocation objectForKey:@"picture"];
    if (picture) {
        const char *strPicture = picture.UTF8String;
        printf("%s \n", strPicture);
    }

    
    // show actions
    
    NSArray*  arrayAction = [self.curentLocation  objectForKey:@"action"];
    
    printf("Ваш выбор:\n\n");
    
    int i = 0;
    
    for (id item in arrayAction) {
        
        NSString *i_str = [NSString stringWithFormat:@"%i",++i];
        
        NSString *variantAction = [NSString stringWithFormat:@"%@.%@",i_str,[item objectForKey:i_str]];
        
        const char *str = variantAction.UTF8String;
        
        printf("%s \n", str);
        
    }
    
    printf("\n"); // enpty line
    
}
   

-(void) setLocations {
    
    if (!self.curentLocation) {
        
        self.curentLocation = [self.allLocation objectForKey:@"1"];
        
    }
    
    if ( self.userAnswer ) {
        
        id goTo = nil;
        
        NSInteger numActionInt = [self.userAnswer intValue];
        
        NSArray*  actions  = [self.curentLocation  objectForKey:@"action"];
        
        self.win = NO;
        
        if ([actions count] >= numActionInt) {
            
            id variant = [actions objectAtIndex:(numActionInt-1)];
            
            goTo = [variant objectForKey:@"goto"];
            
            NSString* win = [variant objectForKey:@"win"];
            
            self.win = ([win  isEqual: @"YES"]) ? YES : NO;
            
        }
        
       self.nextLocation   = [self.allLocation objectForKey:goTo];
       self.curentLocation = self.nextLocation;
       self.userAnswer = nil;
    }

}
    
    
#pragma mark - json
    
- ( NSMutableDictionary * ) readLocationWithJSON {
    
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [thisBundle pathForResource :@"screenplay" ofType:@"json"];
    
    if (!path) {
        NSString* error = @"Invalid screenplay.json file!";
        const char *str = error.UTF8String;
        printf("\n%s \n\n", str);
        return nil;
    }
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    self.allLocation = allKeys;
    
    return allKeys;
    
}
    
    @end
