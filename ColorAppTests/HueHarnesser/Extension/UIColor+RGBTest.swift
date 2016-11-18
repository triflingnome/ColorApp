//
//  UIColor+RGBTest.swift
//  ColorApp
//
//  Created by Michael Berg on 11/18/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class UIColor_RGBTest: XCTestCase {
    
    func testRGBADictionary() {
        let expectedRedValue: CGFloat = 50
        let expectedGreenValue: CGFloat = 220
        let expectedBlueValue: CGFloat = 50
        let expectedAlphaValue: CGFloat = 100
        
        let expectedColor = UIColor(red: expectedRedValue / 255,
                                    green: expectedGreenValue / 255,
                                    blue: expectedBlueValue / 255,
                                    alpha: expectedAlphaValue / 100)
        let actualValues = expectedColor.rgbaDictionary()
        
        if let actualValues = actualValues {
            XCTAssertEqual(expectedRedValue, actualValues["red"])
            XCTAssertEqual(expectedGreenValue, actualValues["green"])
            XCTAssertEqual(expectedBlueValue, actualValues["blue"])
            XCTAssertEqual(expectedAlphaValue, actualValues["alpha"])
        } else {
            XCTFail("RGBA values aren't returning correctly")
        }
    }
    
    func testHueModel() {
        let expectedHue = HHHueModel(name: "Hue", cgRedValue: 35, cgGreenValue: 100, cgBlueValue: 220, cgAlphaValue: 100)
        let expectedColor = expectedHue.color
        
        let actualHue = expectedColor.hueModel()
        
        if let actualHue = actualHue {
            XCTAssertEqual(expectedHue.name, actualHue.name)
            XCTAssertEqual(expectedHue.redValue, actualHue.redValue)
            XCTAssertEqual(expectedHue.greenValue, actualHue.greenValue)
            XCTAssertEqual(expectedHue.blueValue, actualHue.blueValue)
            XCTAssertEqual(expectedHue.alphaValue, actualHue.alphaValue)
        } else {
            XCTFail("Hue model not returning correctly")
        }
    }
    
}
