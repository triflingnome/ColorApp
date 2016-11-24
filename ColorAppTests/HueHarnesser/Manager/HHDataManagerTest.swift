//
//  HHDataManagerTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/22/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHDataManagerTest: XCTestCase {

    func testCreateHue() {
        let dataManager = HHDataManager(withDelegate: nil)
            
        let name = "Test Create Hue"
        let redValue = NSNumber(value: 40.91)
        let greenValue = NSNumber(value: 150.50005)
        let blueValue = NSNumber(value: 10.43)
        let alphaValue = NSNumber(value: 100)
            
        dataManager.createHue(with: name,
                              redValue: redValue,
                              greenValue: greenValue,
                              blueValue: blueValue,
                              alphaValue: alphaValue)
    }

    func testDeleteHue() {
        let dataManager = HHDataManager(withDelegate: nil)
            
        let name = "Test Create Hue"
        let redValue = NSNumber(value: 40.91)
        let greenValue = NSNumber(value: 150.50005)
        let blueValue = NSNumber(value: 10.43)
        let alphaValue = NSNumber(value: 100)
            
        // add object to persistent store
        dataManager.createHue(with: name,
                              redValue: redValue,
                              greenValue: greenValue,
                              blueValue: blueValue,
                              alphaValue: alphaValue)
            
        // delete object from persistent store
        dataManager.deleteHue(at: IndexPath(row: 0, section: 0))
    }
    
}
