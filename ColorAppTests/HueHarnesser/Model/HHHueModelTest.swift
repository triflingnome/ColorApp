//
//  HHHueModelTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/18/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHHueModelTest: XCTestCase {
    
    func testColor() {
        let expectedRed: CGFloat = 210
        let expectedGreen: CGFloat = 50
        let expectedBlue: CGFloat = 100
        let expectedAlpha: CGFloat = 85
        
        let expectedHue = HHHueModel(name: "Test Hue", cgRedValue: expectedRed, cgGreenValue: expectedGreen, cgBlueValue: expectedBlue, cgAlphaValue: expectedAlpha)
        let color = expectedHue.color

        let actualValues = color.rgbaDictionary()
        
        if let actualValues = actualValues {
            XCTAssertEqual(expectedRed, actualValues["red"])
            XCTAssertEqual(expectedGreen, actualValues["green"])
            XCTAssertEqual(expectedBlue, actualValues["blue"])
            XCTAssertEqual(expectedAlpha, actualValues["alpha"])
        } else {
            XCTFail("RGBA values aren't returning correctly")
        }
    }
    
}
