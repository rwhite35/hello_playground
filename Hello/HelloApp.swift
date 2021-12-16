//
//  HelloApp.swift
//  Hello
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
                    CharsStringResult.charsArray(),
                    string: "Friend"
                )
            )
        }
    }
}
