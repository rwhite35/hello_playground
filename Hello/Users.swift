//
//  Users.swift
//  Hello
//
//  Async and Await are new (iOS SDK 15) interfaces for concurrent, asychronous objects
//  when handling stored data either from an API request/response or from internal storage.
//  for more info see https://developer.apple.com/videos/play/wwdc2021/10132/
//
//  Async Await are alternatives to the previous Completion handler and offers synchronization without
//  having to use DispatchQueue.main.async {..} or DispatchGroup.wait() to manage concurrent tasks.
//
//  This example code will handle a JSON response object that is returned from a dummy API users
//  users endpoint which is returned from https://jsonplaceholder.typicode.com/users
//  The Users JSON object has the following multidimensional structure for each user record in the response object.
//  [
//    {
//     id: Int,
//     name: String,
//     email: String,
//     address: {
//       street: String,
//       suite: String,
//       city: String,
//       zipcode: String,
//       geo: { lat: String, lng: String }
//     },
//     phone: String,
//     website: String,
//     company: { name: String, catchPhrase: String, bs: String }
//   },
//   ...
// ]
//
//  A list of decodable JSON Objects defined in the Decodable Protocol
//  https://developer.apple.com/documentation/swift/decodable
//
//  Created by Ron White on 12/28/21.
//
import Foundation
import UIKit
import SwiftUI



// - MARK: Constituent JSON Objects

/// Each nested JSON object we want to parse must be defined
/// in order for Decoder to recursively parse a complete response object
struct Address: Codable, Identifiable
{
    let id = UUID()     // this for Identifiable implementation
    let city: String?
    // declare additional field properties here
}
/// extend each nested object with its enumerated field list and data container
extension Address
{
    private enum CodingKeys: String, CodingKey {
        case city
        // add additional field keys for each declared property
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)
        // decode declared fields
    }
}


/// Repeat the pattern when a response object has more than one nested object.
/// This is only required if we intend to use that objects data
struct Company: Codable, Identifiable
{
    let id = UUID()     // for Identifiable implementation
    let name: String?
    
}
/// extend each nested object with its enumerated field list and data container
extension Company {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}


// - MARK: Composit JSON Object

/// Users Model factory
/// defines the root object structure expected back from /users response.
/// in addition to fields at the root level, there can also be nested JSON
/// Objects.
///
/// - Returns container object of user data
///
struct Users: Codable, Identifiable
{
    let id: Int // the record ID back from API response object
    let name: String
    let email: String
    let address: Address // top level entity for dictionary of address fields
    let company: Company // top level entity for dictionary of company fields
    
    private enum CodingKeys: String, CodingKey {
        case id, name, email, address, company
    }
}
///
/// initializer for APIResponse factory
extension Users {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        
        /// handle nested objects address and company
        address = try container.decodeIfPresent(Address.self, forKey: .address)!
        company = try container.decodeIfPresent(Company.self, forKey: .company)!
    }
}
