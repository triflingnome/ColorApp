//
//  HHLoadNavigationHandlerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/17/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHLoadNavigationHandlerTest: XCTestCase {
    
    func testHandleNavigation() {
        let navigationController = UINavigationController()
        let animated = true
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)
            let pickerViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.colorPicker.rawValue)
            
            //let extractorNavigationHandler = HHExtractorNavigationHandler(navigationController: navigationController, animated: animated, image: actualImage, storyboard: storyboard)
            let loadNavigationHandler = HHLoadNavigationHandler(navigationController: navigationController, animated: animated, loadColorDelegate: pickerViewController as! LoadColorDelegate, storyboard: storyboard)
            loadNavigationHandler.handleNavigation()
            
            let viewControllers = navigationController.viewControllers
            if let expectedLoadViewController = viewControllers[viewControllers.endIndex - 1] as? LoadColorViewController {
                /* TODO: it believe I maybe passing LoadColorDelegate incorrect. Check this post: http://stackoverflow.com/questions/28124684/swift-check-if-generic-type-conforms-to-protocol
                 The idea is to pass an object that conforms to the LoadColorDelegate protocol
                 Also check this post: http://stackoverflow.com/questions/24051396/class-conforming-to-protocol-as-function-parameter-in-swift
                 */
                //XCTAssertEqual(expectedLoadViewController.delegate, pickerViewController as! LoadColorDelegate)
            } else {
                XCTFail("expectedExtractorViewController is not of type ColorExtractorViewController")
            }
        } else {
            XCTFail("main.storyboard or debug image not found")
        }
    }
    
}
