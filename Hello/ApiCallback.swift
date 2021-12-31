//
//  ApiCallbacks.swift
//  Hello
//
//  iOS 14 AND OLDER EXAMPLE ONLY
//
//  Pre Swift 5, iOS/SDK 14 API Callback was the mechanism
//  for handling asynchronous API response data.
//
//  This required several components:
//  - Protocol
//  - Data Container
//  - Callback functions
//
//  Created by Ron White on 12/30/21.
//

import Foundation


// - MARK: GENERIC
// TO ALL COMPLETION CALLBACK API REQUEST

typealias ApiCallback<Value> = (ApiResult<Value>) -> Void

///
/// a generic Request object to use when making an async request
protocol ApiRequest: Codable
{
    // associates each request response with a Decodable object
    associatedtype Response: Decodable
    
    // returns a specific resource part https://<host>/<resource>/<id>
    var resourceName: String { get }
    
    // returns a specific request method types POST, PATCH, GET etc.
    var requestMethod: String { get }
}

///
/// API callback completion success or error handler
enum ApiResult<Value>
{
    case success(Value)
    case error(Error)
}

///
/// a generic response object to use when parsing each response object
struct ApiResponse<Response: Decodable>: Decodable
{
    // sets a pointer to the target data container
    // var name: String?
    var users: AppUsersContainer<Response>
}
///
struct AppUsersContainer<ApiResult: Decodable>: Decodable
{
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)!
    }
}


// - MARK: SPECIFIC
// TO EACH API SERVICE/ENDPOINT REQUEST

///
/// specific to the app users type request
struct AppUserRequest: ApiRequest
{
    typealias Response = [AppUserObject]
    var resourceName: String { return "users" }
    var requestMethod: String { return "GET" }
}

struct AppUserObject: Decodable
{
    let name: String
    /*
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)!
    }
     */
}

///


///
///
struct AppUsers: Decodable
{
    let id: Int?
    let name: String?
    let email: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, email
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
    }
}


