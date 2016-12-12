//
//  HHHueUpdatedDelegate.swift
//  ColorApp
//
//  Created by Michael Berg on 12/12/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

/**
 * This delegate provides a set of methods that a given
 * class can conform to, to provide updated color information
 * to its delegate
 */
protocol HHHueUpdatedDelegate {
    
    /// This instance method provides updated color information in the form of a UIColor object
    func updated(with hue: UIColor)
    
}
