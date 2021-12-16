//
//  Elements.swift
//  Hello
//
//  Created by Ron White on 12/16/21.
//

import Foundation
import SwiftUI

struct Elements: View {
    
   @Binding var row: CharsStringResult.Row
    
    var body: some View {
        TextField("Field",text:$row.text)
    }
}


/// Issue 1: originally this was binding to the container and not a property
/// because CharsStringResult was initializing the object incorrectly.
/// rather then initializing a property which could be bound
struct ElementsList: View {

    @Binding var model: CharsStringResult
    
    var body: some View {
    
        if #available(iOS 15.0, *) {
            let _ = print("ElementsList \(#line): listing CharsStringResult row.")
            List {
                ForEach($model.rows.indices) { index in
                    return Elements(row: self.$model.rows[index])
                }
            }
        } else {
            // Fallback on earlier versions
            Text("SomeText")
        }

    }
}
