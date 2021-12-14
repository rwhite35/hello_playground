//
//  CharsStringResult.swift
//  Hello
//
//  Created by Ron White on 12/14/21.
//

import Foundation

struct CharsStringResult {
    let id = UUID()
    var charString: String
    var charsArray: [Character] = []
    // let charText: Text
    
    init(string: String) {
        charString = string
        charsArray = Array(string)
        // charText = Text(string)
    }
}
