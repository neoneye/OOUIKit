//
//  UIApplicationDelegate+OpenURL.swift
//  OOUIKit
//
//  Created by Karsten Litsche on 02.11.17.
//  
//

import UIKit

/**
 Implementation of UIApplicationDelegate section:
 - Opening a URL-Specified Resource
 See documentation of UIApplicationDelegate for more informations.
 */
public extension UIApplicationDelegateWrap {
    
    public final func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return origin.application?(app, open: url, options: options) ?? false
    }
    
}

/**
 Implementation of UIApplicationDelegate section:
 - Opening a URL-Specified Resource
 See documentation of UIApplicationDelegate for more informations.
 */
public extension UIApplicationDelegateSplitting {
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        for delegate in delegates {
            if let result = delegate.application?(app, open: url, options: options) { return result }
        }
        return false
    }
    
}
