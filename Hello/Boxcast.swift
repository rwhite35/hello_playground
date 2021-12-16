//
//  Boxcast.swift
//  Hello
//
//  a generic plan old swift class with observable properties
//  that when updated, notifies this class.
//
//  Created by Ron White on 12/8/21.
//

import Foundation
import SwiftUI

final class Boxcast: NSObject, ObservableObject
{
    @Published var desc: String = ""
    @Published var id: Int = 0
    
    init(string: String)
    {
        super .init()
        setDesc(string: string)
    }
    
    func setDesc(string: String)
    {
        print("Boxcast \(#line): setDesc String \(string)")
        self.desc = string
    }
    
    func getBoxcastCharacters() -> [Character]
    {
        print("Boxcast \(#line): getting string of characters array.")
        return Array(self.desc)
    }
}


