
#import "VLGroup.h"


static NSString* languages[] = {
    @"Action Script",@"C++/CLI",@"C++",@"ColdFusion",@"D",
    @"Delphi",@"Dylan",@"Eiffel",@"Game Maker Language (GML)",@"Groovy",
    @"haXe",@"Io",@"Java",@"JavaScript",@"MC#",
    @"Object Pascal",@"Objective-C",@"Perl",@"PHP",@"Pike",
    @"Python",@"Ruby",@"Self",@"Simula",@"Smalltalk",
    @"Swift",@"Vala",@"Visual Basic",@"Visual DataFlex",@"Zonnon",
    @"Ada",@"Активный Оберон",@"Компонентный Паскаль",@"Модула-3",@"Оберон-2",
    @"Basic",@"Cg",@"JOVIAL",@"Pascal",@"PL/M",
    @"QBASIC",@"REXX",@"Активный Оберон",@"Алгол 68",@"Алгол",
    @"sh",@"Модула",@"Оберон",@"ПЛ/1",@"Упрощённый Алгол"
};

static int lengCount = 50;

@implementation VLGroup


+(VLGroup*) randomGroup {
    
    VLGroup* group = [[VLGroup alloc] init];
    group.name = languages[arc4random() % lengCount];
    
    return  group;
    
}




@end
