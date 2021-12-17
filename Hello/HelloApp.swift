//
//  HelloApp.swift
//  Hello
//
//  the apps root view. This would be similar to UIApplication(app)
//  requires initializing any Views dependent object. For this
//  project thats Boxcast class and CharsString 
//
//  Created by Ron White on 7/27/21.
//

import SwiftUI

@main
struct HelloApp: App
{

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
    }
}
