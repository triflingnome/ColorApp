//
//  HHNavigationHandleable.swift
//  ColorApp
//
//  Created by Michael Berg on 11/15/16.
//  Copyright © 2016 Michael Berg. All rights reserved.
//

import UIKit

/**
 * This protocol should be adherred to by all navigation handler 
 * classes to provide a common set of:
 * - properties
 * - methods
 * that should be present in all navigation handler classes
 */
protocol HHNavigationHandleable {
    
    var navigationController: UINavigationController { get }
    var animated: Bool { get }
    
    /// This instance method should be implemented to push or pop on navigationController
    func handleNavigation()
    
}
