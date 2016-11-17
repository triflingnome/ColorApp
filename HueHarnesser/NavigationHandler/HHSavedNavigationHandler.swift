//
//  HHSavedNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove storyboard property and inheritance of NSObject once VC isn't in storyboard

@objc class HHSavedNavigationHandler: NSObject, HHNavigationHandleable {
    
    // MARK: Properties
    
    internal let navigationController: UINavigationController
    internal let animated: Bool
    private let storyboard: UIStoryboard
    
    // MARK: Inits
    
    init(navigationController: UINavigationController, animated: Bool, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.storyboard = storyboard
    }
    
    // MARK: Public Methods
    
    func handleNavigation() {
        let savedColorsViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.savedColors.rawValue) as! SavedColorsViewController
        
        navigationController.pushViewController(savedColorsViewController, animated: animated)
    }
    
}
