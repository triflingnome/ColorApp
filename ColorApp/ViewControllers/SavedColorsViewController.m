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

@interface SavedColorsViewController () {
    TipsMethods *tipsMethodsClassInstance;
    DatabaseMethods *databaseMethodsClassInstance;
}

@property (strong, nonatomic) NSMutableArray *name;
@property (strong, nonatomic) NSMutableArray *redval;
@property (strong, nonatomic) NSMutableArray *greenval;
@property (strong, nonatomic) NSMutableArray *blueval;
@property (strong, nonatomic) NSMutableArray *alphaval;

@end

@implementation SavedColorsViewController

// fetches all hues from the phone's database and populates it with their values
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SAVED_COLORS_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    databaseMethodsClassInstance = [[DatabaseMethods alloc] init];
    
    self.name = [[NSMutableArray alloc] init];
    self.redval = [[NSMutableArray alloc] init];
    self.greenval = [[NSMutableArray alloc] init];
    self.blueval = [[NSMutableArray alloc] init];
    self.alphaval = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Hue" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // search for all entity objects with name "Red"
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name = %@)", @"Hue"];
    //[request setPredicate:predicate];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        NSLog(@"No records found");
    } else {
        for (int i = 0;i < [objects count];i++) {
            matches = objects[i];
            [self.name addObject:[matches valueForKey:@"name"]];
            [self.redval addObject:[matches valueForKey:@"redval"]];
            [self.greenval addObject:[matches valueForKey:@"greenval"]];
            [self.blueval addObject:[matches valueForKey:@"blueval"]];
            [self.alphaval addObject:[matches valueForKey:@"alphaval"]];
        }
    }
    
    self.tableView.allowsSelection = NO;
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

#pragma mark -- UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *savedColorsTableIdentifier = @"SavedColorsTableItem";
    
    SavedColorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SavedColorsTableViewCell" bundle:nil] forCellReuseIdentifier:savedColorsTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    }
    
    NSInteger currentRow = indexPath.row;
    cell.hueNameLabel.text = [self.name objectAtIndex:currentRow];
    cell.hueSwatchView.backgroundColor = [UIColor colorWithRed:[[self.redval objectAtIndex:currentRow] floatValue]/255.f
                                                         green:[[self.greenval objectAtIndex:currentRow] floatValue]/255.f
                                                          blue:[[self.blueval objectAtIndex:currentRow] floatValue]/255.f
                                                         alpha:[[self.alphaval objectAtIndex:currentRow] floatValue]/100.f];
    
    cell.deleteHueButton.tag = currentRow;
    [cell.deleteHueButton addTarget:self
                             action:@selector(deleteHue:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


#pragma mark -- SavedColorsTableViewCell methods

// this selector is triggered whenever a the delete action is tapped for a table view cell
- (IBAction)deleteHue:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger indexPathRow = btn.tag;
    NSLog(@"Selected row is: %ld",(long)indexPathRow);
    NSLog(@"Name: %@", [self.name objectAtIndex:indexPathRow]);
    
    // remove Entity from database with name self.name objectAtIndex:indexPathRow
    [databaseMethodsClassInstance removeHueFromDatabaseWithName:[self.name objectAtIndex:indexPathRow]
                                                         RedVal:[[self.redval objectAtIndex:indexPathRow] floatValue]
                                                       GreenVal:[[self.greenval objectAtIndex:indexPathRow] floatValue]
                                                        BlueVal:[[self.blueval objectAtIndex:indexPathRow] floatValue]
                                                       AlphaVal:[[self.alphaval objectAtIndex:indexPathRow] floatValue]];
    
    // remove hue's values from name, rgbaval arrays
    [self.name removeObjectAtIndex:indexPathRow];
    [self.redval removeObjectAtIndex:indexPathRow];
    [self.greenval removeObjectAtIndex:indexPathRow];
    [self.blueval removeObjectAtIndex:indexPathRow];
    [self.alphaval removeObjectAtIndex:indexPathRow];
    
    // reload tableview excluding just deleted hue
    [self.tableView reloadData];
}

@end
