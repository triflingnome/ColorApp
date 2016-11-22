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
    
    private let fetchedResultsController: NSFetchedResultsController<HHHueMO>
    
    // MARK: Inits
    
    init(_ delegate: NSFetchedResultsControllerDelegate?) throws {
        let fetchRequest: NSFetchRequest<HHHueMO> = HHHueMO.fetchRequest()
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [nameSortDescriptor]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedObjectContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: "DataManager")
        
        fetchedResultsController.delegate = delegate

        try fetchedResultsController.performFetch()
        
        self.fetchedResultsController = fetchedResultsController
    }
    
    // MARK: Public Methods

    func createHue(with name: String, redValue: NSNumber, greenValue: NSNumber, blueValue: NSNumber, alphaValue: NSNumber) throws {
        let managedObjectContext = self.fetchedResultsController.managedObjectContext
        
        let hue: HHHueMO
        if #available(iOS 10.0, *) {
            hue = HHHueMO(context: managedObjectContext)
        } else {
            hue = NSEntityDescription.insertNewObject(forEntityName: "Hue", into: managedObjectContext) as! HHHueMO
        }
        
        hue.name = name
        hue.redval = redValue.floatValue
        hue.greenval = greenValue.floatValue
        hue.blueval = blueValue.floatValue
        hue.alphaval = alphaValue.floatValue
        
        try managedObjectContext.save()
    }

    func deleteHue(at indexPath: IndexPath) throws {
        let managedObjectContext = self.fetchedResultsController.managedObjectContext
        managedObjectContext.delete(self.fetchedResultsController.object(at: indexPath))

        try managedObjectContext.save()
    }
    
}
