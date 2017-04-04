
#import <Foundation/Foundation.h>


@interface VLGroup : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSArray* students;

+(VLGroup*) randomGroup;


@end
