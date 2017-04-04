

#import "VLStudent.h"


static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};



static int nameCount = 50;

@implementation VLStudent

+(VLStudent*) randomStudent {
    
    VLStudent* student = [[VLStudent alloc] init];
    student.firstName  = firstNames[arc4random() % nameCount];
   // student.lenguage   = languages[arc4random() % nameCount];
    student.rate       = (CGFloat)(arc4random() % 800 + 200) / 100;
    
    return student;
    
    
}



@end
