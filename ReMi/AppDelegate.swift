//
//  AppDelegate.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: iOS 12 support
//    var window: UIWindow?
//    let user = UserDefaults.standard.object(forKey: "defaultsuserid")
//    let userSelfIdent  = UserDefaults.standard.object(forKey: "userinitialident")

    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: iOS 12 support
//        if #available(iOS 13.0, *) {
//
//        } else {
//            let window = UIWindow(frame: UIScreen.main.bounds)
//            self.window = window
//
//            if(user != nil && userSelfIdent != nil) {
//                let mainstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////                let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "swrevealviewcontroller")  as! UIViewController
//                window.rootViewController = ContentView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "", count: 0)))
//            }
//        }
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        // MARK: iOS 12 support
//        if #available(iOS 13.0, *) {
//            // In iOS 13 setup is done in SceneDelegate
//        } else {
//            self.window?.makeKeyAndVisible()
//        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillResignActive
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidBecomeActive
    }

    // MARK: UISceneSession Lifecycle

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

