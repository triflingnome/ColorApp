//
//  HHExtractorNavigationHandlerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/17/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHExtractorNavigationHandlerTest: XCTestCase {
    
    func testHandleNavigation() {
        let navigationController = UINavigationController()
        let animated = true
        let image = UIImage(named: "Debug")
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName,
           let actualImage = image {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)
            
            let extractorNavigationHandler = HHExtractorNavigationHandler(navigationController: navigationController, animated: animated, image: actualImage, storyboard: storyboard)
            extractorNavigationHandler.handleNavigation()

            let viewControllers = navigationController.viewControllers
            if let expectedExtractorViewController = viewControllers[viewControllers.endIndex - 1] as? ColorExtractorViewController {
                XCTAssertEqual(actualImage, expectedExtractorViewController.chosenImage)
            } else {
                XCTFail("expectedExtractorViewController is not of type ColorExtractorViewController")
            }
        } else {
            XCTFail("main.storyboard or debug image not found")
        }
    }
    
}
