//
//  UIColor+RGB.swift
//  ColorApp
//
//  Created by Michael Berg on 11/18/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//
// Reference for this extension: http://stackoverflow.com/questions/28644311/how-to-get-the-rgb-code-int-from-an-uicolor-in-swift

extension UIColor {
    
    func rgbaDictionary() -> [String: CGFloat]? {
        var initialRedValue: CGFloat = 0
        var initialGreenValue: CGFloat = 0
        var initialBlueValue: CGFloat = 0
        var initialAlphaValue: CGFloat = 0
        
        if self.getRed(&initialRedValue, green: &initialGreenValue, blue: &initialBlueValue, alpha: &initialAlphaValue) {
            let finalRedValue = CGFloat(initialRedValue * 255.0)
            let finalGreenValue = CGFloat(initialGreenValue * 255.0)
            let finalBlueValue = CGFloat(initialBlueValue * 255.0)
            let finalAlphaValue = CGFloat(initialAlphaValue * 100.0)
            
            var rgbaDictionary = [String: CGFloat]()
            rgbaDictionary["red"] = finalRedValue
            rgbaDictionary["green"] = finalGreenValue
            rgbaDictionary["blue"] = finalBlueValue
            rgbaDictionary["alpha"] = finalAlphaValue
            
            return rgbaDictionary
        } else {
            return nil
        }
    }
    
    func hueModel() -> HHHueModel? {
        var initialRedValue: CGFloat = 0
        var initialGreenValue: CGFloat = 0
        var initialBlueValue: CGFloat = 0
        var initialAlphaValue: CGFloat = 0
        
        if self.getRed(&initialRedValue, green: &initialGreenValue, blue: &initialBlueValue, alpha: &initialAlphaValue) {
            let finalRedValue = CGFloat(initialRedValue * 255)
            let finalGreenValue = CGFloat(initialGreenValue * 255)
            let finalBlueValue = CGFloat(initialBlueValue * 255)
            let finalAlphaValue = CGFloat(initialAlphaValue * 100)
            
            return HHHueModel(name: "Hue", cgRedValue: finalRedValue, cgGreenValue: finalGreenValue, cgBlueValue: finalBlueValue, cgAlphaValue: finalAlphaValue)
        } else {
            return nil
        }
    }
    
}
