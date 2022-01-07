//
//  Elements.swift
//  Hello
//
//  Constructs a dynamic list view of text fields bound (Binding<Elements.Row>)
//  to a Sequence of indexed rows of text that are passed in when added
//  to a view element ie NavigationView.
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
    
    /// store each dynamic links text
    /// Row will be bound to ElementsCell view
    struct Row : Identifiable {
        let id = UUID()
        var text = ""
    }
    
    /// rows property is used for view output
    /// and is bound to the ElementsList view
    var rows: [Row]
    
    init<S: Sequence>(rowContent: S) where S.Element: strIndex {
        /// receives input data from view property $listElement
        /// which is the ContentView that created the ElementsList
        self.rows = rowContent.map {
            let row = Row( text: String($0) )
            // lets see whats going on
            var str = String($0)
            let num = str.removeLast()
            let uuid = row.id
            print("Elements \(#line): Row \(num) received text: \(String($0)) and sets UUID: \(uuid)")
            
            return row
        }
    }
}

/// Elements Cell
///  defines the content of the row being rendered
///    -Returns TextField with Row.text value
struct ElementsCell: View
{
    @Binding var row: Elements.Row
    
    var body: some View {
        let _ = print("ElementsCell \(#line): adding Cell to List.")
        TextField("Title",text:$row.text)
    }
}


/// Elements List
///  builds one or more rows of dynamic list.
///  SwiftUI.List is roughly equivalent to UIKit.UITableView
///   - Returns List object with one or more rows of input cells
struct ElementsList: View
{
    @Binding var model: Elements
    
    var body: some View {
    
        if #available(iOS 15.0, *) {
            let _ = print("ElementsList \(#line): adding the List.")
            List {
                ForEach($model.rows.indices) { index in
                    return ElementsCell(row: self.$model.rows[index])
                }
            }
        } else {  // Fallback on earlier versions
            let _ = print("ElementsList \(#line): adding List with only first Cell")
            List {
                TextField("Title",text:$model.rows[0].text)
            }
        }

    }
}
