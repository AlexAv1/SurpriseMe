//
//  AppDelegate.swift
//  Test
//
//  Created by iMac on 09.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // - UI
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }
    
}

// MARK: -
// MARK: - Configure

private extension AppDelegate {
    
    func configure() {
        configureAlamofireActivityLogger()
    }
    
    func configureAlamofireActivityLogger() {
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
    }

}
