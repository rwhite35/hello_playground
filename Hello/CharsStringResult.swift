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
    
    init(string: String) {
        charString = string
        charsArray = Array(string)
    }
    
    func getUUID() -> String {
        let string = String(id.uuidString)
        return String(string.prefix(8))
    }
}
