//
//  ContentView.swift
//  Hello
//
//  Created by Ron White on 7/27/21.
//

import SwiftUI


struct ContentView: View
{
    
    @StateObject var boxCast: Boxcast
    let charString = CharsStringResult.init(string: "Happy")
    let charsView = Chars.init(
        model: CharsModel(),
        textFieldHasFocus: true
    )
    
    func getBoxcast(i:Int) -> String {
        let array = boxCast.getBoxcastCharacters()
        let range = i..<array.count
        var string = ""
        
        for index in range {
            string = string + String(array[index])
            print("ContentView.getBoxcast index \(index) with range \(range) produces character \(string)")
        }
        return string
    }
    
    var body: some View {
        
            /// Text views as a V stack
            VStack(alignment: .trailing) {
                Spacer()
                /// Text row 1
                Text("UUID: \(charString.getUUID())...")
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                /// Text row 2
                charsView.body
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                /// Text row 3
                Text(getBoxcast(i:2))
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                /// Text row 4, Each char'
                
                Spacer()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        if #available(iOS 15.0, *) {
            /// for Preview frame
        } else {
            /// Fallback on earlier versions
        }
    }
}
