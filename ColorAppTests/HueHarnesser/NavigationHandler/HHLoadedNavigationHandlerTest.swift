//
//  HHLoadedNavigationHandlerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/17/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHLoadedNavigationHandlerTest: XCTestCase {
    
    func testHandleNavigation() {
        let navigationController = UINavigationController()
        let animated = false
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)

            // set up navigation stack
            let pickerViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.colorPicker.rawValue)
            let loadViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.loadColor.rawValue)
            navigationController.setViewControllers([pickerViewController, loadViewController], animated: animated)
            
            // perform navigation
            let loadedNavigationHandler = HHLoadedNavigationHandler(navigationController: navigationController, animated: animated)
            loadedNavigationHandler.handleNavigation()
            
            // verify state of navigation stack as expected
            let viewControllers = navigationController.viewControllers
            guard viewControllers[viewControllers.endIndex - 1] is ColorPickerViewController else {
                XCTFail("top view controller is not of type ColorPickerViewController")
                return
            }
        } else {
            XCTFail("main.storyboard not found")
        }
    }
    
}
