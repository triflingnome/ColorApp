//
//  HHSavedNavigationHandlerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/17/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHSavedNavigationHandlerTest: XCTestCase {
    
    func testHandleNavigation() {
        let navigationController = UINavigationController()
        let animated = false
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)
            
            let savedNavigationHandler = HHSavedNavigationHandler(navigationController: navigationController, animated: animated, storyboard: storyboard)
            savedNavigationHandler.handleNavigation()
            
            let viewControllers = navigationController.viewControllers
            guard viewControllers[viewControllers.endIndex - 1] is SavedColorsViewController else {
                XCTFail("top view controller is not of type SavedColorsViewController")
                return
            }
        } else {
            XCTFail("main.storyboard not found")
        }
    }
    
}
