//
//  Boxcast.swift
//  Hello
//
//  Created by Ron White on 12/8/21.
//

import Foundation
import SwiftUI

final class Boxcast: NSObject, ObservableObject
{
    @Published var desc: String = ""
    @Published var id: Int = 0
    
    init(string: String) {
        super .init()
        print("Boxcast.init what is an \(string)")
        setDesc(string: string)
    }
    
    func setId(count: Int)
    {
        print("bx \(#line) Boxcast.setId count \(count)")
        self.id = count
    }
    
    func setDesc(string: String)
    {
        print("bx \(#line) Boxcast.setDesc String \(string)")
        self.desc = string
    }
    
    func getBoxcastView() -> [Character]
    {
        print("bx \(#line) getting string of characters array.")
        return Array(self.desc)
    }
}


