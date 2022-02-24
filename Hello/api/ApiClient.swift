//
//  ApiClient.swift
//  Hello
//
//  Created by Ron White on 12/30/21.
//
import Foundation

class ApiClient
{
    let session = URLSession(configuration: .default)
    var url: URL?
    var data: Dictionary<String,Any>?
    var users = [Users]()
    
    init(){
        self.url = URL(string: "https://jsonplaceholder.typicode.com/users")
    }
    ///
    /// completion callback implementation
    internal func previousFetchUsers<T: ApiRequest>(
        _ request: T,
        completion: @escaping ApiCallback<AppUsersContainer<T.Response>>
    ) {
        // setup request object headers
        var requestObject = URLRequest(url: self.url!)
        requestObject.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestObject.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // define the request task which gets called Boxcast init
        let task = session.dataTask(with: requestObject) { data, response, error in
            
            guard let responseData = data, error == nil else {
                print("\(#line) API response error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            // print("previousFetchUsers has response data, parsing JSON response.")
            do {
                let users = try JSONDecoder().decode([Users].self, from: responseData)
                self.setUsers(users: users)
            }
            catch {
                print("\(#line) error on handling response object: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    ///
    /// setter/getter
    private func setUsers(users: [Users] ) {
        print("ApiClient \(#line) setUsers Hello.Users: \(users)")
        self.users = users
    }
    public func getUsers() -> [Users] {
        print("ApiClient \(#line) getUsers was called.")
        return self.users
    }
}
