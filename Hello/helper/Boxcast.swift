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
    @Published var name: String = ""
    
    /// a remote url for receiving back a JSON response objects
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    /// list of Users from asynchronous call to a remote host
    private var users = [Users]()
    
    /// instance of ApiClient
    /// private let apiClient = ApiClient()
    
    /// on initialization, receives a JSON response object of users data.
    init(string: String) async
    {
        super .init()
        setDesc(string: string)
        
        /// get user names from API endpoint using async and await
        if #available(iOS 15.0, *) {
            // NOTE: runs asynchronously, immediately and
            // doesn't wait for viewDidLoad(UIKit/UIViewController)
            /*
            async {
                let users = await fetchUsers()
                self.setUsers(users: users)
            }
            */
            
        } else {
            // NOTE: fallback on SDK 14 and older completion implementation
            // runs after the View has been added to the stack
            // requires DispatchQueue.main.async in order to 'update View'
            let apiClient = ApiClient()
            apiClient.previousFetchUsers( AppUserRequest() ) { response in
                print("Boxcast \(#line) previousFatchUsers response \(response)")
                switch response {
                case .success :  print("Boxcast \(#line) fallback completion was a success.")
                case .error : print("Boxcast \(#line) fallback completion was a fail.")
                }
                // on response
                let users = apiClient.getUsers()
                self.setUsers(users: users)
            }
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
    
    
    /// setter/getter for Users object
    func setUsers(users: [Users])
    {
        print("Boxcast \(#line): Hello.Users has received users JSON Object and called setUsers.")
        // print("Boxcast.Hello.Users users: \(users)")
        self.users = users
        self.setUsersName(name: self.users.first!.name)
    }
    func getUsers() -> [Users] { return self.users }
    
    
    /// setter/getter for Users.first.name Property
    func setUsersName(name: String)
    {
        print("Boxcast \(#line) setUsersName ")
        self.name = self.users.first?.name ?? "Bully"
    }
    func getUsersName() -> String { return self.name }
    
    
    
    // - MARK: Validate User Name
    
    /// validate the user name by checking the user name length
    ///  - Returns User name string on success or throws an error on fail
    func validateUserName(_ username: String?) throws -> String {
        guard let username = username else { throw BoxcastValidationError.invalidValue }
        guard username.count > 3 else { throw BoxcastValidationError.usernameToShort }
        guard username.count < 24 else { throw BoxcastValidationError.usernameToLong }
        return username
    }
    
    
    
    // - MARK: Users Async & Await Method
    
    /// fetch a collection of Users data using async interface
    /// async() replaces Completion handlers since iOS 15.0
    ///
    /// - Returns collection of Users data
    @available(iOS 15.0.0, *)
    private func fetchUsers() async -> [Users]
    {
        guard let url = url else {
            print("\(#line) unable to assign url.")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([Users].self, from: data)
            return users
        }
        catch {
            print("\(#line) unable to receive data from remote host: \(error)")
            return []
        }
    }
}

enum BoxcastValidationError: LocalizedError
{
    case invalidValue
    case usernameToShort
    case usernameToLong
    
    var errorDescription: String?
    {
        switch self {
        case .invalidValue: return "Invalid input for username!"
        case .usernameToShort: return "Username is to short!"
        case .usernameToLong: return "Username is to long!"
        }
    }
}
