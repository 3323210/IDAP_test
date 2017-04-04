

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VLStudent : NSObject

@property (strong, nonatomic) NSString*  firstName;
@property (strong, nonatomic) NSString*  lenguage;
@property (assign, nonatomic) CGFloat    rate;

+(VLStudent*) randomStudent;


@end
