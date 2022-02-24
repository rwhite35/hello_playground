//
//  CharsStringResult.swift
//  Hello
//

//
//  Created by Ron White on 12/14/21.
//

import Foundation
import SwiftUI

/// Characters Model
///  simple model that defines a custom type object
struct CharsStringModel
{    
    typealias charsArray = Array<CharsStringModel>
    var charString: String = "some string"
}


/// declare a new label view
struct CharsLabel: View
{
    var body: some View {
        let _ = print("CharsLabel \(#line): added to ContentView")
        VStack {
            Label("Any Label Now", systemImage: "sun.max")
                .font(.callout)
        }
    }
}


final class CharsString: NSObject, ObservableObject
{
    @Published var desc: String = ""
    var charsStrResult:CharsStringModel?
    let id = UUID()
    
    init(
        _:CharsStringModel.charsArray,
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
