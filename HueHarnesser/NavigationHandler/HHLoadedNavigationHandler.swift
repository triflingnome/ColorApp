//
//  HHLoadedNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove storyboard property and inheritance of NSObject once VC isn't in storyboard

@objc class HHLoadedNavigationHandler: NSObject, HHNavigationHandleable {
    
    let navigationController: UINavigationController
    let animated: Bool
    
    init(navigationController: UINavigationController, animated: Bool) {
        self.navigationController = navigationController
        self.animated = animated
    }
    
    func handleNavigation() {
        // check to make sure ColorPickerVC is before LoadColorVC before popping
        let viewControllers = navigationController.viewControllers
        guard viewControllers[viewControllers.count - 2] as ColorPickerViewController else {
            return
        }
        
        navigationController.popViewController(animated: animated)
    }
    
}
