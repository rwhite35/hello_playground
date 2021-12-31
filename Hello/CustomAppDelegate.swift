//
//  CustomAppDelegate.swift
//  Hello
//
//  This is a custom AppDelegate for connecting UIApplication (App)
//  to the SwiftUI App Object (WindowGroup).  The object will persist
//  and has state same as the App Object.
//
//  Created by Ron White on 12/31/21.
//

import UIKit


class CustomAppDelegate: NSObject, UIApplicationDelegate
{
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        /// similar to AppDelegate you would do any work on launch complete
        printCustomAppDelegate()
        
        return true
    }
    
    
    /// configure a UIScene delegate for connecting SwiftUI to AppDelegate
    /// - Returns: UIScene session configuration
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        let config = UISceneConfiguration(name: "Hello.App SceneDelegate", sessionRole: connectingSceneSession.role)
        config.delegateClass = HelloAppSceneDelegate.self
        return config
    }
    
    
    /// call after Hello.App object init, then on AppDelegate did finish launching
    func printCustomAppDelegate()
    {
        print("AppDelegate initialized and didFinishLaunchingWithOptions")
    }
    
}


/// UIScene Delegate custom class for connecting AppDelegate to UIScene
/// initialized on AppDelegate launch. Add any function here that would normally
/// be called in the AppDelegate.
/// For example, UIApplicationShortcutItem must now be called from the SceneDelegate
/// and not the UIApplicationDelegate.
class HelloAppSceneDelegate: UIResponder, UIWindowSceneDelegate
{
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ){
        // NOTE: add any delegates here that would have been called from UIApplicationDelegate
        // some delegates will only be called from SceneDelegate and others may still require
        // UIApplicationDelegate.  Know what is called from where.
        print("AppDelegate connecting UIScene delegate")
    }
    
}
