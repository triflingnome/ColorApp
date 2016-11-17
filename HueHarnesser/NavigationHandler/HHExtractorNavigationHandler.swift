//
//  HHExtractorNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

// TODO: remove storyboard property and inheritance of NSObject once VC isn't in storyboard

@objc class HHExtractorNavigationHandler: NSObject, HHNavigationHandleable {
    
    let navigationController: UINavigationController
    let animated: Bool
    let image: UIImage
    let storyboard: UIStoryboard
    
    init(navigationController: UINavigationController, animated: Bool, image: UIImage, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.image = image
        self.storyboard = storyboard
    }
    
    func handleNavigation() {
        let colorExtractorViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.colorExtractor.rawValue) as! ColorExtractorViewController
        colorExtractorViewController.chosenImage = image
        
        navigationController.pushViewController(colorExtractorViewController, animated: animated)
    }
    
}
