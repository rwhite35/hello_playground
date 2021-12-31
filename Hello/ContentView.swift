//
//  ContentView.swift
//  Hello
//
//  assembles our view from constituent parts
//
//  Created by Ron White on 7/27/21.
//

import SwiftUI


struct ContentView: View
{
    /// on state change notify these publishers
    @StateObject var boxCast: Boxcast
    @StateObject var charsString: CharsString
    
    /// this needed hoisted to property status instead of trying to initialize in the body View
    @State var listElements = Elements(
        rowContent:(1...5).map { String("Row \($0)") }
    )
    
    /// instantiate Form view
    let charFormView = CharForm.init(
        model: CharFormModel(),
        textFieldHasFocus: true
    )
    
    /// instantiate Label view
    let charsLabel = CharsLabel.init()
    
    /// work methods
    func getBoxcast(i:Int) -> String
    {
        let array = boxCast.getBoxcastCharacters()
        let range = i..<array.count
        var string = ""
        
        for index in range {
            string = string + String(array[index])
            // print("CV.getBoxcast index \(index) with range \(range) produces character \(string)")
        }
        return string
    }
    
    // for text field
    func getUsersName() -> String
    {
        let name = boxCast.getUsersName()
        return name
    }
    
    func getCharsStringUUID() -> String
    {
        let uuid = charsString.getUUID()
        return uuid
    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            Spacer()
            /// Text row
            Text("UUID: \(getCharsStringUUID())...")
                .padding(20)
                .multilineTextAlignment(.center)
            
            /// Text first Users.name
            Text("Hello \(getUsersName())")
                .padding(20)
                .multilineTextAlignment(.center)
                
            /// attach Form view
            charFormView.body
                .padding(20)
                .multilineTextAlignment(.center)
                
            /// Text row
            Text(getBoxcast(i:2))
                .padding(20)
                .multilineTextAlignment(.center)
                
            /// attach Label view
            charsLabel.body
                .padding(20)
                .multilineTextAlignment(.center)
                
            /// attached ElementsList with CharsStringResult rows of content
            NavigationView {
                ElementsList(model: $listElements.projectedValue).body
            }
            /// done with layout
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
