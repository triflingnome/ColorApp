//
//  HHPickerNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

@objc class HHPickerNavigationHandler: NSObject, HHNavigationHandleable {
    
    let navigationController: UINavigationController
    let animated: Bool
    let storyboard: UIStoryboard
    
    init(navigationController: UINavigationController, animated: Bool, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.storyboard = storyboard
    }
    
    func handleNavigation() {
        let colorPickerViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.colorPicker.rawValue) as! ColorPickerViewController
        
        navigationController.pushViewController(colorPickerViewController, animated: animated)
    }
    
}
