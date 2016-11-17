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
        let animated = false
        let storyboardName = Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String?
        
        if let actualStoryboardName = storyboardName {
            let storyboard = UIStoryboard(name: actualStoryboardName, bundle: Bundle.main)
            let pickerViewController = storyboard.instantiateViewController(withIdentifier: HHViewControllerIdentifiers.colorPicker.rawValue) as! ColorPickerViewController

            let loadNavigationHandler = HHLoadNavigationHandler(navigationController: navigationController, animated: animated, loadColorDelegateViewController: pickerViewController, storyboard: storyboard)
            loadNavigationHandler.handleNavigation()
            
            let viewControllers = navigationController.viewControllers
            if let expectedLoadViewController = viewControllers[viewControllers.endIndex - 1] as? LoadColorViewController {
                XCTAssertEqual(expectedLoadViewController.delegate as! ColorPickerViewController, pickerViewController)
            } else {
                XCTFail("expectedExtractorViewController is not of type ColorExtractorViewController")
            }
        } else {
            XCTFail("main.storyboard not found")
        }
    }
    
}
