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
        return UIColor(red: CGFloat(redValue.floatValue) / CGFloat(255),
                       green: CGFloat(greenValue.floatValue) / CGFloat(255),
                       blue: CGFloat(blueValue.floatValue) / CGFloat(255),
                       alpha: CGFloat(alphaValue.floatValue) / CGFloat(100))
    }
    
    // MARK: Inits
    
    init(name: String, redValue: NSNumber, greenValue: NSNumber, blueValue: NSNumber, alphaValue: NSNumber) {
        self.name = name
        self.redValue = redValue
        self.greenValue = greenValue
        self.blueValue = blueValue
        self.alphaValue = alphaValue
    }
    
}
