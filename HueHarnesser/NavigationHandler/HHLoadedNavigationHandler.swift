//
//  HHLoadedNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove inheritance of NSObject once VC isn't in storyboard

@objc class HHLoadedNavigationHandler: NSObject, HHNavigationHandleable {
    
    // MARK: Properties
    
    internal let navigationController: UINavigationController
    internal let animated: Bool
    
    // MARK: Inits
    
    init(navigationController: UINavigationController, animated: Bool) {
        self.navigationController = navigationController
        self.animated = animated
    }
    
    // MARK: Public Methods
    
    func handleNavigation() {
        // check to make sure ColorPickerVC is before LoadColorVC before popping
        let viewControllers = navigationController.viewControllers
        guard viewControllers[viewControllers.count - 2] is ColorPickerViewController,
            viewControllers[viewControllers.count - 1] is LoadColorViewController else {
            return
        }
        
        navigationController.popViewController(animated: animated)
    }
    
}
