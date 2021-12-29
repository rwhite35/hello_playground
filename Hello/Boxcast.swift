//
//  Boxcast.swift
//  Hello
//
//  a generic plan old swift class with observable properties
//  that when updated, notifies this class.
//
//  Created by Ron White on 12/8/21.
//

import Foundation
import SwiftUI

final class Boxcast: NSObject, ObservableObject
{
    @Published var desc: String = ""
    @Published var id: Int = 0
    
    /// a remote url for receiving back a JSON response objects
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    /// list of APIResponse user names from asynchronous call to a remote url
    private var users = [Users]()
    
    /// on initialization, receives a JSON response object of users data.
    init(string: String)
    {
        super .init()
        setDesc(string: string)
        
        /// get user names from API endpoint using async and await
        if #available(iOS 15.0, *) {
            async {
                let users = await fetchUsers()
                self.users = users
            }
        } else { // fallback on earlier completion implementation
            // do something
        }
    }
    
    func setDesc(string: String)
    {
        print("Boxcast \(#line): setDesc String \(string)")
        self.desc = string
    }
    
    func getBoxcastCharacters() -> [Character]
    {
        print("Boxcast \(#line): getting string of characters array.")
        return Array(self.desc)
    }
    
    // - MARK: Users Response Object
    
    /// fetch a collection of Users data using async interface
    /// async() replaces Completion handlers since iOS 15.0
    ///
    /// - Returns collection of Users data
    ///
    @available(iOS 15.0.0, *)
    private func fetchUsers() async -> [Users]
    {
        // fail fast if remote host is not available
        guard let url = url else { return [] }
        
        // Async.await replaces Completion handlers for optional(Data.Element.UInt8)
        // Data object which holds the Users (/users endpoint) response object.
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([Users].self, from: data)
            
            print("Boxcast \(#line) has users data \(users)")
            
            return users
        }
        catch {
            print("Boxcast \(#line) unable to receive data from remote host: \(error)")
            return []
        }
    }
    
    
    // - MARK: Old Previous Response Handling
    
    /// @deprecated
    /// fetch the same collection of user names but using Completion handlers
    /// but using a (nested) class that implements BXHttpsApiProtocol
    class OldCompletionClass: BXHttpsApiProtocol
    {
        let session = URLSession(configuration: .default)
        var url: URL?
        var data: Dictionary<String,Any>?
        
        
        
        init(){
            self.url = URL(string: "https://jsonplaceholder.typicode.com/users")
        }
        
        
        
        internal func previousFetchUsers(_ request: URLRequest,
                                         onSuccess: @escaping BXSuccessCallback,
                                         onError: @escaping BXErrorCallback
        ){
            // setup our request object
            var requestObject = URLRequest(url: self.url!)
            requestObject.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requestObject.addValue("application/json", forHTTPHeaderField: "Accept")
            
            // get the data
            let task = session.dataTask(with: requestObject) { data, response, error in
                
                guard let responseData = data, error == nil else {
                    print("OldCompletionClass \(#line) API response error: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                // parse response
                do {
                    let parsedResponse = try JSONDecoder().decode(BXHttpsApiContainer.Row.self, from: responseData)
                    if ( parsedResponse.user.isEmpty ) {
                        onError(error!)
                        
                    } else {
                        print("previousFetchUsers \(#line) has parsed response: \(parsedResponse)")
                    }
                }
                catch {
                    
                    print("OldCompletion \(#line) errored on handling response object: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }   /// closes OldCompletionClass
    
}


/// FOR DEMO ONLY
///
/// Pre iOS 15 API Callback Protocols
/// defined how the response object should be handled
protocol BXHttpsApiProtocol
{
    typealias BXSuccessCallback = ( [String:Any]? ) -> Void
    typealias BXErrorCallback = (Error) -> Void
    
    func previousFetchUsers(_ request: URLRequest,
                            onSuccess: @escaping BXSuccessCallback,
                            onError: @escaping BXErrorCallback )
}


/// Pre iOS 15 API Response Container
/// defined the structure of the response object
struct BXHttpsApiContainer: Decodable
{
    /// [ String, Any ]
    struct Row: Decodable {
        var user = "default"
        var id = UUID()
    }
    var rows: [Row]
}
