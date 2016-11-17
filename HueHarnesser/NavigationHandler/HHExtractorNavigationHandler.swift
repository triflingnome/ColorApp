//
//  HHExtractorNavigationHandler.swift
//  ColorApp
//
//  Created by Michael Berg on 11/16/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import UIKit

class HHExtractorNavigationHandler: HHNavigationHandleable {
    
    let navigationController: UINavigationController
    let animated: Bool
    let image: UIImage
    let storyboard: UIStoryboard // will be removed once ColorExtractorVC is rewritten to not use storyboard
    
    init(navigationController: UINavigationController, animated: Bool, image: UIImage, storyboard: UIStoryboard) {
        self.navigationController = navigationController
        self.animated = animated
        self.image = image
        self.storyboard = storyboard
    }
    
    func handleNavigation() {
        let colorExtractorViewController = storyboard.instantiateViewController(withIdentifier: "ColorExtractorViewController") as! ColorExtractorViewController
        colorExtractorViewController.chosenImage = image
        
        navigationController.pushViewController(colorExtractorViewController, animated: animated)
    }
    
}
