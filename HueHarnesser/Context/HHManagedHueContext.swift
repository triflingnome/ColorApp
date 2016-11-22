//
//  HHManagedHueContext.swift
//  ColorApp
//
//  Created by Michael Berg on 11/19/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//



@objc class HHManagedHueContext: NSObject {
 
    /*
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
     }
     }
     */
    /*static func fetchHuesFromContext() -> [HHHueModel] {
 
    }*/
 
    /*
     - (void)saveHueToContextWithHue:(HHHueModel *)hue {
     id<UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
     NSManagedObjectContext *context = [(AppDelegate *)appDelegate managedObjectContext];
     NSManagedObject *newHue;
     
     newHue = [NSEntityDescription insertNewObjectForEntityForName:@"Hue"
     inManagedObjectContext:context];
     [newHue setValue:hue.name forKey:@"name"];
     [newHue setValue:hue.redValue forKey:@"redval"];
     [newHue setValue:hue.greenValue forKey:@"greenval"];
     [newHue setValue:hue.blueValue forKey:@"blueval"];
     [newHue setValue:hue.alphaValue forKey:@"alphaval"];
     
     NSError *error;
     [context save:&error];
     }
     */
    static func saveHueToContext(with hue: HHHueModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        if let context = context {
            let hueToSave = NSEntityDescription.insertNewObject(forEntityName: "Hue", into: context)
            hueToSave.setValue(hue.name, forKey: "name")
            hueToSave.setValue(hue.redValue, forKey: "redval")
            hueToSave.setValue(hue.greenValue, forKey: "greenval")
            hueToSave.setValue(hue.blueValue, forKey: "blueval")
            hueToSave.setValue(hue.alphaValue, forKey: "alphaval")
            
            do {
                try context.save()
            } catch {
                print("saveHueToContext failed")
            }
        }
    }
    
    /*
     - (void)removeHueFromContextWithHue:(HHHueModel *)hue {
     id<UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
     NSManagedObjectContext *context = [(AppDelegate *)appDelegate managedObjectContext];
     
     NSEntityDescription *hueEntity = [NSEntityDescription entityForName:@"Hue" inManagedObjectContext:context];
     NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
     [fetch setEntity:hueEntity];
     
     NSPredicate *namePred = [NSPredicate predicateWithFormat:@"(name == %@)", hue.name];
     NSPredicate *redValPred = [NSPredicate predicateWithFormat:@"(redval == %f)", hue.redValue];
     NSPredicate *greenValPred = [NSPredicate predicateWithFormat:@"(greenval == %f)", hue.greenValue];
     NSPredicate *blueValPred = [NSPredicate predicateWithFormat:@"(blueval == %f)", hue.blueValue];
     NSPredicate *alphaValPred = [NSPredicate predicateWithFormat:@"(alphaval == %f)", hue.alphaValue];
     
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
     }
     */
    static func deleteHueFromContext(with hue: HHHueModel) {
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        if let context = context {
            let hueEntity = NSEntityDescription.entity(forEntityName: "Hue", in: context)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            fetchRequest.entity = hueEntity
            
            let namePredicate = NSPredicate(format: "(name == %@)", argumentArray: [hue.name])
            let redValuePredicate = NSPredicate(format: "(redval == %.20f)", argumentArray: [hue.redValue.doubleValue])
            let greenValuePredicate = NSPredicate(format: "(greenval == %.20f)", argumentArray: [hue.greenValue.doubleValue])
            let blueValuePredicate = NSPredicate(format: "(blueval == %.20f)", argumentArray: [hue.blueValue.doubleValue])
            let alphaValuePredicate = NSPredicate(format: "(alphaval == %.20f)", argumentArray: [hue.alphaValue.doubleValue])
            
            let predicates = [namePredicate, redValuePredicate, greenValuePredicate, blueValuePredicate, alphaValuePredicate]
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            fetchRequest.predicate = compoundPredicate
            
            do {
                //let fetchedHues = try context.execute(fetchRequest)
                let fetchedHues = try context.fetch(fetchRequest)
                
                for fetchedHue in fetchedHues as! [NSManagedObject] {
                    context.delete(fetchedHue)
                }
                
                try context.save()
            } catch {
                print("deleteHueFromContext failed")
            }
        }
    }
    
}
