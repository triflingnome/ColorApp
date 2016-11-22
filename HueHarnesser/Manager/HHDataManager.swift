//
//  HHDataManager.swift
//  ColorApp
//
//  Created by Michael Berg on 11/21/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import CoreData

@objc class HHDataManager: NSObject {
    
    // MARK: Properties
    
    // TODO: NSFetchedResultsController computed property
    var fetchedResultsController: NSFetchedResultsController<HHHueMO> {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
        
        let fetchRequest: NSFetchRequest<HHHueMO> = HHHueMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedObjectContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: "DataManager")
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
        
        do {
            try aFetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        return aFetchedResultsController
    }
    
//    var _fetchedResultsController: NSFetchedResultsController<HHHueMO>? = nil
    
    // MARK: Public Methods
    
    // TODO: class func saveHue(with hue: HHHueMO) { }
    
    // TODO: class func deleteHue(with hue: HHHueMO) { }
    
}
