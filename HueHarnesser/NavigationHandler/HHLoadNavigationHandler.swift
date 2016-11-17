//
//  HHLoadNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove storyboard property and inheritance of NSObject once VC isn't in storyboard

@objc class HHLoadNavigationHandler: NSObject, HHNavigationHandleable {
    
    // MARK: Properties
    
    internal let navigationController: UINavigationController
    internal let animated: Bool
    private let loadColorDelegateViewController: ColorPickerViewController
    private let storyboard: UIStoryboard
    
    // MARK: Inits

    init(navigationController: UINavigationController, animated: Bool, loadColorDelegateViewController: ColorPickerViewController, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.loadColorDelegateViewController = loadColorDelegateViewController
        self.storyboard = storyboard
    }
    
    // MARK: Public Methods
    
    func handleNavigation() {
        let loadColorViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.loadColor.rawValue) as! LoadColorViewController
        loadColorViewController.delegate = loadColorDelegateViewController
        
        navigationController.pushViewController(loadColorViewController, animated: animated)
    }
    
}
