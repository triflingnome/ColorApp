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
        do {
            let dataManager = try HHDataManager(nil)
            
            let expectedName = "Test Create Hue"
            let expectedRedValue = NSNumber(value: 40.91)
            let expectedGreenValue = NSNumber(value: 150.50005)
            let expectedBlueValue = NSNumber(value: 10.43)
            let expectedAlphaValue = NSNumber(value: 100)
            
            try dataManager.createHue(with: expectedName,
                                      redValue: expectedRedValue,
                                      greenValue: expectedGreenValue,
                                      blueValue: expectedBlueValue,
                                      alphaValue: expectedAlphaValue)
        } catch {
            let error = error as NSError
            XCTFail("Test failed with error: \(error)")
        }
    }

    func testDeleteHue() {
        do {
            let dataManager = try HHDataManager(nil)
            
            let expectedName = "Test Create Hue"
            let expectedRedValue = NSNumber(value: 40.91)
            let expectedGreenValue = NSNumber(value: 150.50005)
            let expectedBlueValue = NSNumber(value: 10.43)
            let expectedAlphaValue = NSNumber(value: 100)
            
            // add object to persistent store
            try dataManager.createHue(with: expectedName,
                                      redValue: expectedRedValue,
                                      greenValue: expectedGreenValue,
                                      blueValue: expectedBlueValue,
                                      alphaValue: expectedAlphaValue)
            
            // delete object from persistent store
            try dataManager.deleteHue(at: IndexPath(row: 0, section: 0))
        } catch {
            let error = error as NSError
            XCTFail("Test failed with error: \(error)")
        }
    }
    
}
