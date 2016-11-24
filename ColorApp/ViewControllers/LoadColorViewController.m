//
//  LoadColorViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/29/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Similar in functionality to SavedColorsVC, but doesn't allow for deletion, only relaying
//  values back to ColorPickerVC. Implements the Delegate design pattern to send those values
//  back to ColorPickerVC

#import "LoadColorViewController.h"

#import "ColorApp-Swift.h"

@interface LoadColorViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@property (strong, nonatomic) NSFetchedResultsController<HHHueMO *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation LoadColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LOAD_COLORS_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

- (void)configureCell:(LoadColorTableViewCell *)cell withHue:(HHHueMO *)hue {
    cell.hueNameLabel.text = hue.name;
    cell.hueSwatchView.backgroundColor = [UIColor colorWithRed:hue.redval/255
                                                         green:hue.greenval/255
                                                          blue:hue.blueval/255
                                                         alpha:hue.alphaval/100];
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
    static NSString *loadColorTableIdentifier = @"LoadColorTableItem";
    
    LoadColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadColorTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib: [UINib nibWithNibName:@"LoadColorTableViewCell" bundle:nil] forCellReuseIdentifier:loadColorTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:loadColorTableIdentifier];
    }

    HHHueMO *hue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withHue:hue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHHueMO *hue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    float *hueValues = (float *)malloc(sizeof(float) * 4);
    hueValues[0] = hue.redval;
    hueValues[1] = hue.greenval;
    hueValues[2] = hue.blueval;
    hueValues[3] = hue.alphaval;
    
    [self.delegate returnHueValues:hueValues];
    
    HHLoadedNavigationHandler *loadedNavigationHandler = [[HHLoadedNavigationHandler alloc] initWithNavigationController:self.navigationController
                                                                                                                animated:YES];
    [loadedNavigationHandler handleNavigation];
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
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withHue:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
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
                                                                                                                      cacheName:@"LoadColor"];
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
