//
//  HHHueModel.swift
//  ColorApp
//
//  Created by Michael Berg on 11/18/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

@objc class HHHueModel: NSObject {
    
    // MARK: Properties
    
    let name: String
    let redValue: NSNumber
    let greenValue: NSNumber
    let blueValue: NSNumber
    let alphaValue: NSNumber
    
    var color: UIColor {
        return UIColor(red: CGFloat(redValue.doubleValue) / CGFloat(255),
                       green: CGFloat(greenValue.doubleValue) / CGFloat(255),
                       blue: CGFloat(blueValue.doubleValue) / CGFloat(255),
                       alpha: CGFloat(alphaValue.doubleValue) / CGFloat(100))
    }
    
    // MARK: Inits
    
    init(name: String, redValue: Double, greenValue: Double, blueValue: Double, alphaValue: Double) {
        self.name = name
        self.redValue = NSNumber(value: redValue)
        self.greenValue = NSNumber(value: greenValue)
        self.blueValue = NSNumber(value: blueValue)
        self.alphaValue = NSNumber(value: alphaValue)
    }
    
    init(name: String, cgRedValue: CGFloat, cgGreenValue: CGFloat, cgBlueValue: CGFloat, cgAlphaValue: CGFloat) {
        self.name = name
        self.redValue = NSNumber(value: Double(cgRedValue))
        self.greenValue = NSNumber(value: Double(cgGreenValue))
        self.blueValue = NSNumber(value: Double(cgBlueValue))
        self.alphaValue = NSNumber(value: Double(cgAlphaValue))
    }
    
}
