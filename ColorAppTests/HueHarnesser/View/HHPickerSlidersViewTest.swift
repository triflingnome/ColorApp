//
//  HHPickerSlidersViewTest.swift
//  ColorApp
//
//  Created by Michael Berg on 12/21/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import XCTest

@testable import ColorApp

class HHPickerSlidersViewTest: XCTestCase {

    func testConfigure() {
        let sliderPickersView = HHPickerSlidersView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        let expectedRedValue = CGFloat(floatLiteral: 200)
        let expectedGreenValue = CGFloat(floatLiteral: 50)
        let expectedBlueValue = CGFloat(floatLiteral: 50)
        let expectedAlphaValue = CGFloat(floatLiteral: 85)
        
        sliderPickersView.configure(with: nil, color: UIColor(red: expectedRedValue / CGFloat(floatLiteral: 255),
                                                              green: expectedGreenValue / CGFloat(floatLiteral: 255),
                                                              blue: expectedBlueValue / CGFloat(floatLiteral: 255),
                                                              alpha: expectedAlphaValue / CGFloat(floatLiteral: 100)))

        guard let redSlider = sliderPickersView.redSlider,
            let greenSlider = sliderPickersView.greenSlider,
            let blueSlider = sliderPickersView.blueSlider,
            let alphaSlider = sliderPickersView.alphaSlider else {
            XCTFail("Could not find sliders")
            return
        }

        XCTAssertEqual(expectedRedValue, CGFloat(floatLiteral: CGFloat.NativeType(redSlider.value)))
        XCTAssertEqual(expectedGreenValue, CGFloat(floatLiteral: CGFloat.NativeType(greenSlider.value)))
        XCTAssertEqual(expectedBlueValue, CGFloat(floatLiteral: CGFloat.NativeType(blueSlider.value)))
        XCTAssertEqual(expectedAlphaValue, CGFloat(floatLiteral: CGFloat.NativeType(alphaSlider.value)))

        guard let redValueLabel = sliderPickersView.redValueLabel,
            let greenValueLabel = sliderPickersView.greenValueLabel,
            let blueValueLabel = sliderPickersView.blueValueLabel,
            let alphaValueLabel = sliderPickersView.alphaValueLabel else {
            XCTFail("Could not find slider labels")
            return
        }

        XCTAssertEqual(String(describing: expectedRedValue), redValueLabel.text)
        XCTAssertEqual(String(describing: expectedGreenValue), greenValueLabel.text)
        XCTAssertEqual(String(describing: expectedBlueValue), blueValueLabel.text)
        XCTAssertEqual(String(describing: expectedAlphaValue), alphaValueLabel.text)
    }
    
}

private extension HHPickerSlidersView {

    var redSlider: UISlider? {
        if let redSlider = self.viewWithTag(1) as? UISlider {
            return redSlider
        } else {
            return nil
        }
    }
    
    var greenSlider: UISlider? {
        if let greenSlider = self.viewWithTag(2) as? UISlider {
            return greenSlider
        } else {
            return nil
        }
    }
    
    var blueSlider: UISlider? {
        if let blueSlider = self.viewWithTag(3) as? UISlider {
            return blueSlider
        } else {
            return nil
        }
    }
    
    var alphaSlider: UISlider? {
        if let alphaSlider = self.viewWithTag(4) as? UISlider {
            return alphaSlider
        } else {
            return nil
        }
    }

    var redValueLabel: UILabel? {
        if let redSliderLabel = self.viewWithTag(5) as? UILabel {
            return redSliderLabel
        } else {
            return nil
        }
    }

    var greenValueLabel: UILabel? {
        if let greenSliderLabel = self.viewWithTag(6) as? UILabel {
            return greenSliderLabel
        } else {
            return nil
        }
    }

    var blueValueLabel: UILabel? {
        if let blueSliderLabel = self.viewWithTag(7) as? UILabel {
            return blueSliderLabel
        } else {
            return nil
        }
    }

    var alphaValueLabel: UILabel? {
        if let alphaSliderLabel = self.viewWithTag(8) as? UILabel {
            return alphaSliderLabel
        } else {
            return nil
        }
    }
    
}
