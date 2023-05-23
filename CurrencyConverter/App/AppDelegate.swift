//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow()
        let navigationController = UINavigationController()
        let assmblyBuilder = ModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assmblyBuilder)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

