//
//  AppDelegate.swift
//  ProfileDemo
//
//  Created by a on 5/13/20.
//  Copyright © 2020 a. All rights reserved.
//

import UIKit
import SQLite


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    let isLoggedIn = UserDefaults.standard.bool(forKey: "IsLoggedIn")
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    let signedUp = UserDefaults.standard.bool(forKey: "SignedUP")

      func setRootView(){
             if signedUp {
                 if isLoggedIn {
                 let rootVC = (mainStoryBoard.instantiateViewController(withIdentifier: "MoviesVC") as! MoviesVC)
                 let navigationController = UINavigationController(rootViewController: rootVC)
                 let window = UIApplication.shared.windows.first

                 window?.rootViewController = navigationController
                 } else {
                     let rootVC = (mainStoryBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC)
                     let navigationController = UINavigationController(rootViewController: rootVC)
                     let window = UIApplication.shared.windows.first

                     window?.rootViewController = navigationController
                 }
             } else {
                 let rootVC = (mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
                 let navigationController = UINavigationController(rootViewController: rootVC)
                 let window = UIApplication.shared.windows.first

                 window?.rootViewController = navigationController
             }
     }
    func createIfNotExisst(){
           if DataBaseManager.shared.tableCreated() {
               DataBaseManager.shared.createTable()
           // DataBaseManager.shared.historySearchTable
           }
        
       }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
               setRootView()
               DataBaseManager.shared.connectDataBase()
               createIfNotExisst()
        return true

    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
