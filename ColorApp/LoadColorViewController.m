//
//  LoadColorViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/29/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "LoadColorViewController.h"

@interface LoadColorViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@property (strong, nonatomic) NSMutableArray *name;
@property (strong, nonatomic) NSMutableArray *redval;
@property (strong, nonatomic) NSMutableArray *greenval;
@property (strong, nonatomic) NSMutableArray *blueval;
@property (strong, nonatomic) NSMutableArray *alphaval;

@end

@implementation LoadColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LOAD_COLORS_TITLE;
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
    
}// end viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

#pragma mark -- UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.name.count;
}// end tableView: numberOfRowsInSection:

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *loadColorTableIdentifier = @"LoadColorTableItem";
    
    LoadColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadColorTableIdentifier];
    
    if (cell == nil) {
        //cell = [[LoadColorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadColorTableIdentifier];
        [tableView registerNib: [UINib nibWithNibName:@"LoadColorTableViewCell" bundle:nil] forCellReuseIdentifier:loadColorTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:loadColorTableIdentifier];
    }// end if
    
    NSInteger currentRow = indexPath.row;
    cell.hueNameLabel.text = [self.name objectAtIndex:currentRow];
    cell.hueSwatchView.backgroundColor = [UIColor colorWithRed:[[self.redval objectAtIndex:currentRow] floatValue]/255.f
                                                         green:[[self.greenval objectAtIndex:currentRow] floatValue]/255.f
                                                          blue:[[self.blueval objectAtIndex:currentRow] floatValue]/255.f
                                                         alpha:[[self.alphaval objectAtIndex:currentRow] floatValue]/100.f];
    
    return cell;
}// end tableView: cellForRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    float *hueValues = (float *)malloc(sizeof(float) * 4);
    hueValues[0] = [[self.redval objectAtIndex:indexPath.row] floatValue];
    hueValues[1] = [[self.greenval objectAtIndex:indexPath.row] floatValue];
    hueValues[2] = [[self.blueval objectAtIndex:indexPath.row] floatValue];
    hueValues[3] = [[self.alphaval objectAtIndex:indexPath.row] floatValue];
    
    [self.delegate returnHueValues:hueValues];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
