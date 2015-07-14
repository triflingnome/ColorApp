//
//  DatabaseMethods.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "DatabaseMethods.h"

@implementation DatabaseMethods

- (void)saveHueToDatabaseWithName:(NSString *)name
                           RedVal:(float)redval
                         GreenVal:(float)greenval
                          BlueVal:(float)blueval
                         AlphaVal:(float)alphaval {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newHue;
    newHue = [NSEntityDescription insertNewObjectForEntityForName:@"Hue" inManagedObjectContext:context];
    [newHue setValue:name forKey:@"name"];
    [newHue setValue:[NSNumber numberWithFloat:redval] forKey:@"redval"];
    [newHue setValue:[NSNumber numberWithFloat:greenval] forKey:@"greenval"];
    [newHue setValue:[NSNumber numberWithFloat:blueval] forKey:@"blueval"];
    [newHue setValue:[NSNumber numberWithFloat:alphaval] forKey:@"alphaval"];
    
    NSError *error;
    [context save:&error];
}// end saveHueToDatabaseWith ...

/*- (void)removeHueFromDatabaseWithName:(NSString *)name
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
 }// end removeHueFromDatabaseWithName:*/

- (void)removeHueFromDatabaseWithName:(NSString *)name
                               RedVal:(float)redval
                             GreenVal:(float)greenval
                              BlueVal:(float)blueval
                             AlphaVal:(float)alphaval {
    NSLog(@"in DatabaseMethods");
    
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
    //[fetch setPredicate:namePred];
    [fetch setPredicate:compoundedPred];
    
    NSError *fetchError;
    NSArray *fetchedHues = [context executeFetchRequest:fetch error:&fetchError];
    
    NSLog(@"%lu", (unsigned long)[fetchedHues count]);
    
    for (NSManagedObject *hue in fetchedHues) {
        [context deleteObject:hue];
    }// end for
    
    NSError* saveError = nil;
    [context save:&saveError];
}// end removeHueFromDatabaseWithName:

@end
