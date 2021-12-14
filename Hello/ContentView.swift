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
        let array = boxCast.getBoxcastView()
        return String(array[i])
    }
    
    var body: some View {
        
            /// Text views as a V stack
            VStack(alignment: .trailing) {
                Spacer()
                /// Text row 1
                Text("UUID: \(charString.id.uuidString)")
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                /// Text row 2
                charsView.body
                    .padding(20)
                    .multilineTextAlignment(.center)
                
                /// Text row 3
                Text(getBoxcast(i: 0))
                    .padding(20)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        if #available(iOS 15.0, *) {
            //ContentView(boxCast: Boxcast.getBoxcastView(Boxcast.didChangeValue(forKey: "id")))
            //    .previewInterfaceOrientation(.portraitUpsideDown)
        } else {
            // Fallback on earlier versions
        }
    }
}
