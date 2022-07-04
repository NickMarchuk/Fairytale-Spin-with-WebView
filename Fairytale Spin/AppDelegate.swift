//
//  AppDelegate.swift
//  Fairytale Spin
//
//  Created by Nick M on 18.06.2022.
//

import UIKit
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var orientation:UIInterfaceOrientationMask = .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        guard let propertiesPath = Bundle.main.path(forResource: "afdevkey_donotpush", ofType: "plist"),
//            let properties = NSDictionary(contentsOfFile: propertiesPath) as? [String:String] else {
//                fatalError("Cannot find `afdevkey_donotpush`")
//        }
//        guard let appsFlyerDevKey = properties["appsFlyerDevKey"],
//                   let appleAppID = properties["appleAppID"] else {
//            fatalError("Cannot find `appsFlyerDevKey` or `appleAppID` key")
//        }
//        AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerDevKey
//        AppsFlyerLib.shared().appleAppID = appleAppID
//        //  Set isDebug to true to see AppsFlyer debug logs
//        AppsFlyerLib.shared().isDebug = true
//        
//        AppsFlyerLib.shared().delegate = self
//        
//        NotificationCenter.default.addObserver(self,
//        selector: #selector(didBecomeActiveNotification),
//        // For Swift version < 4.2 replace name argument with the commented out code
//        name: UIApplication.didBecomeActiveNotification, //.UIApplicationDidBecomeActive for Swift < 4.2
//        object: nil)
        
        return true
    }
    
//    @objc func didBecomeActiveNotification() {
//        AppsFlyerLib.shared().start()
//    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
   
}

