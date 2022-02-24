//
//  Elements.swift
//  Hello
//
//  Constructs a list of dynamic text fields bound (Binding<Elements.Row>)
//  to a Sequence of indexed rows of text that are passed in when added to
//  the content view.
//
//  reference: https://developer.apple.com/forums/thread/124322
//
//  Created by Ron White on 12/16/21.
//

import Foundation
import SwiftUI

///  Elements Model
///  defines the List.Elements properties and type components
///    - Returns container object with bindable Row property
struct Elements
{
    typealias strIndex = StringProtocol
    
    struct Row : Identifiable {
        var text = ""
        let id = UUID()
    }
    
    var rows: [Row]
    
    init<S: Sequence>(rowContent: S) where S.Element: strIndex {
        self.rows = rowContent.map { Row( text: String($0) ) }
        let indx = self.rows.startIndex
        let txt = self.rows[indx]
        print("Elements \(#line) the Element at index \(indx) has string: \(txt)")
    }
}

/// Elements Cell
///  defines the content of the row being rendered
///    -Returns TextField with Row.text value
struct ElementsCell: View
{
    @Binding var row: Elements.Row
    
    var body: some View {
        TextField("Title",text:$row.text)
    }
}


/// Elements List
///  builds one or more rows of dynamic list.
///   - Returns List object with one or more rows of input cells
struct ElementsList: View
{
    @Binding var model: Elements
    
    var body: some View {
    
        if #available(iOS 15.0, *) {
            let _ = print("ElementsList \(#line): adding Cell rows.")
            List {
                ForEach($model.rows.indices) { index in
                    return ElementsCell(row: self.$model.rows[index])
                }
            }
        } else {  // Fallback on earlier versions
            let _ = print("ElementsList \(#line): adding one Cell row.")
            List {
                TextField("Title",text:$model.rows[0].text)
            }
        }

    }
}
