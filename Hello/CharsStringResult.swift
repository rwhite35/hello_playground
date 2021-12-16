//
//  CharsStringResult.swift
//  Hello
//
//  a complex object with lots of nuanced features
//  good reference: https://developer.apple.com/forums/thread/124322
//
//  Created by Ron White on 12/14/21.
//

import Foundation
import SwiftUI

struct CharsStringResult {
    
    typealias charsArray = Array<CharsStringResult>
    
    struct Row : Identifiable {
        var text = "default"
        let id = UUID()
    }

    // var rows: [Row] = [Row]()
    var rows: [Row]
    var charString: String = "some string"
    
    init<S: Sequence>(rowContent: S) where S.Element: StringProtocol {
        self.rows = rowContent.map { Row( text: String($0) ) }
    }
    
    /*
    /// this was the wrong initializer for what we wanted to do
    /// which is defering the content to where the view calls it
    init(string: String) {
        charString = string
        print("CharsStringResult \(#line): init string \(string)")
        rows = [Row(text: "string")]
    }
    */
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
