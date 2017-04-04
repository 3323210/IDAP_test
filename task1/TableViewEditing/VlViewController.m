

#import "VlViewController.h"
#import "VLGroup.h"
#import "VLStudent.h"

@interface VlViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groupsArray;

@end

@implementation VlViewController


-(void) loadView {
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
}

-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.groupsArray = [NSMutableArray array];
    
    for (int i = 0; i < (arc4random() % 6 + 5); i++) {
        
        VLGroup* group = [VLGroup randomGroup];
        
        NSMutableArray* array = [NSMutableArray array];
        
        for (int j = 0; j < (arc4random() % 5 + 2); j++) {
            [array addObject:[VLStudent randomStudent]];
        }
        
        group.students = array;
        
        [self.groupsArray  addObject:group];
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = @"Developers";
    
    UIBarButtonItem* editeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit)
                                                                                 target:self
                                                                                 action:@selector(actionEdite:)];
    
    self.navigationItem.rightBarButtonItem = editeButton;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAddSection:)];
    self.navigationItem.leftBarButtonItem = addButton;
    
}

#pragma mark - action

-(void) actionEdite:(UIBarButtonItem*) sender {
    
    self.tableView.editing = self.tableView.isEditing ?  NO : YES;
    
    UIBarButtonSystemItem item  = self.tableView.isEditing ?  UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit;
    
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                            target:self action:@selector(actionEdite:)];
    self.navigationItem.rightBarButtonItem = button;
  
}


-(void) actionAddSection:(UIBarButtonItem*) sender {
    
    VLGroup* group = [VLGroup randomGroup];
    group.students = @[[VLStudent randomStudent], [VLStudent randomStudent], [VLStudent randomStudent]];
    
    static int newSectionIndex = 0;
    
    [self.groupsArray insertObject:group atIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    NSIndexSet* insertSection = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    UITableViewRowAnimation animation = arc4random() % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
    [self.tableView insertSections:insertSection
                  withRowAnimation:animation];
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    double delayInSeconds = 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
}

#pragma mark PrivateMethods

- (NSInteger) getIndexStudent:(NSInteger) index {
    
    return index;//(index - 1);
    
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.groupsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsArray objectAtIndex:section] name];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    VLGroup* group = [self.groupsArray objectAtIndex:section];
    
    return [group.students count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell* cell ;
    NSString* identifier;
    
    if (indexPath.row == 0 ) {
        
        
        identifier = @"cellAddStudent";
        cell       = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text       = @"Tap to add new students";
        cell.textLabel.textColor  = [UIColor blueColor];
        
    } else {
        
        
        identifier = @"cell";
        cell       = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        VLGroup* group     = [self.groupsArray objectAtIndex:indexPath.section];
        VLStudent* student = [group.students objectAtIndex:[self getIndexStudent:indexPath.row]];
        
        cell.textLabel.text       = student.firstName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%2.1f$", student.rate];
        
        if (student.rate > 7) {
            cell.detailTextLabel.textColor = [UIColor blueColor];
        } else if (student.rate > 5)  {
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else {
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
    }
    
    return cell;
    
}


// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        return NO;
    }
    return YES;
}

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSLog(@"commitEditingStyle %i",editingStyle);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        VLGroup* groupe    = [self.groupsArray objectAtIndex:indexPath.section];
        VLStudent* student = [groupe.students objectAtIndex:[self getIndexStudent:indexPath.row]];
        
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray:groupe.students];
        [tempArray removeObject:student];
        groupe.students = tempArray;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    }
    
}

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  NSLog(@"canMoveRowAtIndexPath");
    
    return  indexPath.row > 0;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    VLGroup* groupe    = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    VLStudent* student = [groupe.students objectAtIndex:[self getIndexStudent:sourceIndexPath.row]];
    
    NSMutableArray* tempArray = [[NSMutableArray alloc] initWithArray: groupe.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        groupe.students = tempArray;
        
    } else {
        
        [tempArray removeObject:student];
        groupe.students = tempArray;
        
        VLGroup* destinationGroup   = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [[NSMutableArray alloc] initWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row];
        destinationGroup.students  = tempArray;
    }
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath");
    
    if (indexPath.row == 0 ) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        VLGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        VLStudent* newStudent = [VLStudent randomStudent];
        
        static NSUInteger numNewSection = 0;
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray: group.students ];
        [tempArray insertObject:newStudent atIndex:numNewSection];
        group.students  = tempArray;
        
        [tableView beginUpdates];
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:numNewSection + 1 inSection:indexPath.section];
        
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        double delayInSeconds = 0.3f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    
    }
    
}


@end






















































