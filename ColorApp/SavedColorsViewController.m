//
//  SavedColorsViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "SavedColorsViewController.h"

@interface SavedColorsViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@property (strong, nonatomic) NSMutableArray *name;
@property (strong, nonatomic) NSMutableArray *redval;
@property (strong, nonatomic) NSMutableArray *greenval;
@property (strong, nonatomic) NSMutableArray *blueval;
@property (strong, nonatomic) NSMutableArray *alphaval;

@end

@implementation SavedColorsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SAVED_COLORS_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    [tipsMethodsClassInstance showStarterTipFromViewController:self];
    
    self.name = [[NSMutableArray alloc] init];
    self.redval = [[NSMutableArray alloc] init];
    self.greenval = [[NSMutableArray alloc] init];
    self.blueval = [[NSMutableArray alloc] init];
    self.alphaval = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
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
        }// end for
        
    }// end if-else
    
    self.tableView.allowsSelection = NO;
}// end viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [sampleData count];
    return self.name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *savedColorsTableIdentifier = @"SavedColorsTableItem";
    
    SavedColorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SavedColorsTableViewCell" bundle:nil] forCellReuseIdentifier:savedColorsTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:savedColorsTableIdentifier];
    }// end if
    
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

- (IBAction)deleteHue:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger indexPathRow = btn.tag;
    NSLog(@"Selected row is: %ld",(long)indexPathRow);
    NSLog(@"Name: %@", [self.name objectAtIndex:indexPathRow]);
    
    // remove Entity from database with name self.name objectAtIndex:indexPathRow
    [self removeHueFromDatabaseWithName:[self.name objectAtIndex:indexPathRow]
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
}// deleteHue

- (void)removeHueFromDatabaseWithName:(NSString *)name
                               RedVal:(float)redval
                             GreenVal:(float)greenval
                              BlueVal:(float)blueval
                             AlphaVal:(float)alphaval {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *hueEntity = [NSEntityDescription entityForName:@"Hue" inManagedObjectContext:context];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:hueEntity];
    
    //[NSPredicate predicateWithFormat:@"(name = %@)", @"Hue"]
    NSPredicate *namePred = [NSPredicate predicateWithFormat:@"(name == %@)", name];
    NSPredicate *redValPred = [NSPredicate predicateWithFormat:@"(redval == %f)", redval];
    NSPredicate *greenValPred = [NSPredicate predicateWithFormat:@"(greenval == %f)", greenval];
    NSPredicate *blueValPred = [NSPredicate predicateWithFormat:@"(blueval == %f)", blueval];
    NSPredicate *alphaValPred = [NSPredicate predicateWithFormat:@"(alphaval == %f)", alphaval];
    
    NSArray *predicateCollection = [NSArray arrayWithObjects:namePred, redValPred, greenValPred, blueValPred, alphaValPred, nil];
    NSPredicate *compoundedPred = [NSCompoundPredicate andPredicateWithSubpredicates:predicateCollection];
    [fetch setPredicate:compoundedPred];
    
    NSError *fetchError;
    NSArray *fetchedHues = [context executeFetchRequest:fetch error:&fetchError];
    
    for (NSManagedObject *hue in fetchedHues) {
        [context deleteObject:hue];
    }// end for

    NSError* saveError = nil;
    [context save:&saveError];
}// end removeHueFromDatabaseWithName:

@end
