//
//  AppDelegate.swift
//  Swift_Method_Swizzling
//
//  Created by DFD on 2018/2/20.
//  Copyright © 2018年 DFD. All rights reserved.
//  swift4.0 实现交换方法，只是来源 http://blog.yaoli.site/post/%E5%A6%82%E4%BD%95%E4%BC%98%E9%9B%85%E5%9C%B0%E5%9C%A8Swift4%E4%B8%AD%E5%AE%9E%E7%8E%B0Method-Swizzling

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere{
    static func harmlessFunction(){
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0..<typeCount{
            ((types[index]) as? SelfAware.Type)?.awake()
        }
    }
}

extension UIApplication {
    private static let runOnce :Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}















