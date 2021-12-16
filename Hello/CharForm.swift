//
//  CharForm.swift
//  Hello
//
//  Created by Ron White on 12/8/21.
//

import Foundation
import SwiftUI

public struct CharForm: View
{
    @ObservedObject var model: CharFormModel
    @State public var textFieldHasFocus: Bool
    var fieldName = "Typewriter"
    
    public var body: some View {
        let _ = print("CharForm \(#line): added to ContentView")
        
        Form {
            if #available(iOS 15.0, *) {
                TextField(
                    text:$model.textString,
                    prompt: Text("Type text here")
                ) {
                    Text(fieldName).foregroundColor(Color.green)
                }
            } else { // Fallback on earlier versions
                TextField(
                    "Typewriter",
                    text:$model.textString
                )
            }
        }
        .frame(height: 125.00, alignment: .center)
    }
}
