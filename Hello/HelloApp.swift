//
//  HelloApp.swift
//  Hello
//
//  Startup Lifecycle
//  In a SwiftUI project, the main App object WindowGroup scene
//  initializes before AppDelegate and is the highest order of class.
//
//  ScenePhase tracks the current scene state through an environmental
//  @Environment(\.scenePhase)
//
//  Connecting a WindowGroup to an AppDelegate is handled through
//  an instance of the wrapper class UIApplicationDelegateAdapter()
//
//
//  Created by Ron White on 7/27/21.
//

import SwiftUI

@main
struct HelloApp: App
{
    /// connecting WindowGroup to AppDelegate
    @UIApplicationDelegateAdaptor(CustomAppDelegate.self) var appDelegate
    
    /// a trackable state of current scene
    @Environment(\.scenePhase) var scenePhase
    
    /// initialize any configurable frameworks or other required startup methods
    init() {
        printMe()
    }
    
    /// initialize the WindowGroup (the main scene)
    var body: some Scene
    {
        WindowGroup<ContentView> {
            
            ContentView.init(
                boxCast: Boxcast.init(string: "Boxcast"),
                charsString: CharsString.init(
                    CharsStringModel.charsArray(),
                    string: "Friend"
                )
            )
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active: print("ScenePhase is ACTIVE")
            case .inactive: print("ScenePhase is INACTIVE")
            case .background: print("ScenePhase is BACKGROUND")
            @unknown default: print("ScenePhase is UNKNOWN")
            }
        }
    }
    
    func printMe() {
        print("AppObject is initializing")
    }
}
