//
//  ContentView.swift
//  Hello
//
//  Initial UI for Hello app. assembles our view from constituent parts.
//
//  SwiftUI dictim: Views are functions of their states.
//  - SwiftUI manages Views very differently compared to Storyboard
//  interface projects. And probably the biggest difference is that
//  a View is NOT re-rendered with each new request, rather it is
//  retrieved from a previous or initial state.
//
//  Additionally, states are immutable and only properties wrapped
//  with the @State* modifier can be updated. SwiftUI requires that
//  elements value is a reflection of the stored property its bound to.
//  This 'two-way binding' is indicated with '$' symbol.
//
//  Example: @State var listElements is an example of this relationship.
//
//  NavigationView interface combines the styling features of UINavigationBar
//  and controls behavior of UINavigationController all in one.
//
//  Created by Ron White on 7/27/21.
//

import SwiftUI


struct ContentView: View
{
    /// on state change notify these publishers
    @StateObject var boxCast: Boxcast
    @StateObject var charsString: CharsString
    
    /// validate User Name
    @State private var showAlert = false
    
    /// initializes Elements with one or more dynamic rows of text
    /// NavigationView and listElements have a two-way binding relationship
    /// meaning the view can read from and write to listElements.
    @State var listElements = Elements(
        rowContent:(1...3).map { String("View \($0)") }
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
        
        for index in range { string = string + String(array[index]) }
        return string
    }
    
    /// for text field
    func getUsersName() -> String
    {
        do {
            let username = try boxCast.validateUserName(boxCast.getUsersName())
            return username
        } catch {
            showAlert = true
            return "Error: \(error)"
        }
    }
    
    /// get Characters UUID
    func getCharsStringUUID() -> String
    {
        let uuid = charsString.getUUID()
        return uuid
    }
    
    /// navigation data
    let navigate = Bundle.main.decode([NavigateSection].self, from: "nav.json")
    
    var body: some View {
        
        /// app navigation
        NavigationView {
            // let _ = print("CV \(#line) navigate value: \(navigate)")
            List {
                ForEach(navigate) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: LinkDetail(item: item)) {
                                LinkRow(item: item)
                            }
                        }
                    }
                }
            }
        }
        
        VStack(alignment: .trailing) {
            Spacer()
            /// Text row
            /*
            Text("UUID: \(getCharsStringUUID())...")
                .padding(20)
                .multilineTextAlignment(.center)
            */
            /// Text first Users.name
            Text("Hello \(getUsersName())")
                .padding(20)
                .multilineTextAlignment(.center)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid User Name"),
                          message: Text("Name was to short or to lond"),
                          dismissButton: Alert.Button.cancel(Text("Dismiss")))
                }
                
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
                
            /// attached ElementsList with one or more rows of content.
            /// NavigationView is bound to $listElements and can read or write back to this property
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
