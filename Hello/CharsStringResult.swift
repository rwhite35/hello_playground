//
//  CharsStringResult.swift
//  Hello
//
//  Created by Ron White on 12/14/21.
//

import Foundation

struct CharsStringResult {
    
    typealias charsArray = Array<CharsStringResult>
    var charString: String
    
    init(string: String) {
        charString = string
        print("CharsStringResult \(#line): init string \(string)")
    }
}

final class CharsString: NSObject, ObservableObject
{
    @Published var desc: String = ""
    var charsStrResult:CharsStringResult?
    let id = UUID()
    
    init(
        _:CharsStringResult.charsArray,
        string: String
    ) {
        super .init()
        setDesc(string: string)
        charsStrResult?.charString = string
    }
    
    func setDesc(string: String)
    {
        print("CharsString \(#line): setDesc string \(string)")
        self.desc = string
    }
    
    func getUUID() -> String
    {
        let string = String(id.uuidString)
        return String(string.prefix(8))
    }
}
