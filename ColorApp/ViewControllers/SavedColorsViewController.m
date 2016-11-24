//
//  SavedColorsViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  This screen shows the user all their saved colors and allows them to delete any color
//  they wish. SavedColorTableViewCell is used for this screen's table view

#import "SavedColorsViewController.h"

#import "ColorApp-Swift.h"

@interface SavedColorsViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@property (strong, nonatomic) NSFetchedResultsController<HHHueMO *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation SavedColorsViewController

// fetches all hues from the phone's database and populates it with their values
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SAVED_COLORS_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    self.tableView.allowsSelection = NO;
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

- (void)configureCell:(SavedColorsTableViewCell *)cell withHue:(HHHueMO *)hue row:(NSInteger)row {
    cell.hueNameLabel.text = hue.name;
    cell.hueSwatchView.backgroundColor = [UIColor colorWithRed:hue.redval/255 green:hue.greenval/255 blue:hue.blueval/255 alpha:hue.alphaval/100];
    
    cell.deleteHueButton.tag = row;
    [cell.deleteHueButton addTarget:self action:@selector(deleteHue:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *savedColorsTableIdentifier = @"SavedColorsTableItem";
    
    SavedColorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SavedColorsTableViewCell" bundle:nil] forCellReuseIdentifier:savedColorsTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    }

    HHHueMO *hue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withHue:hue row:indexPath.row];
    
    return cell;
}

#pragma mark -- NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withHue:anObject row:indexPath.row];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark -- SavedColorsTableViewCell methods

// this selector is triggered whenever a the delete action is tapped for a table view cell
- (IBAction)deleteHue:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger indexPathRow = btn.tag;

    NSIndexPath *indexPathToDelete = [NSIndexPath indexPathForRow:indexPathRow inSection:0];
    [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPathToDelete]];
}

#pragma mark -- Lazy Loading

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = appDelegate.persistentContainer.viewContext;
    }
    return _managedObjectContext;
}

- (NSFetchedResultsController<HHHueMO *> *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hue"];
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    request.sortDescriptors = @[nameSortDescriptor];

    NSFetchedResultsController<HHHueMO *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                                           managedObjectContext:self.managedObjectContext
                                                                                                             sectionNameKeyPath:nil
                                                                                                                      cacheName:@"SavedColors"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

@end
