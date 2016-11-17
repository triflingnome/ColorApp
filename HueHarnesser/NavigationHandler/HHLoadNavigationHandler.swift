//
//  HHLoadNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove storyboard property and inheritance of NSObject once VC isn't in storyboard

@objc class HHLoadNavigationHandler: NSObject, HHNavigationHandleable {
    
    let navigationController: UINavigationController
    let animated: Bool
    let loadColorDelegate: LoadColorDelegate
    let storyboard: UIStoryboard
    
    init(navigationController: UINavigationController, animated: Bool, loadColorDelegate: LoadColorDelegate, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.loadColorDelegate = loadColorDelegate
        self.storyboard = storyboard
    }
    
    func handleNavigation() {
        let loadColorViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.loadColor.rawValue) as! LoadColorViewController
        loadColorViewController.delegate = loadColorDelegate
        
        navigationController.pushViewController(loadColorViewController, animated: animated)
    }
    
}
