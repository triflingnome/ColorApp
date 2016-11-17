//
//  HHPickerNavigationHandlerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/17/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHPickerNavigationHandlerTest: XCTestCase {
    
    func testHandleNavigation() {
        let navigationController = UINavigationController()
        let animated = false
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)

            let pickerNavigationHandler = HHPickerNavigationHandler(navigationController: navigationController, animated: animated, storyboard: storyboard)
            pickerNavigationHandler.handleNavigation()
            
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
