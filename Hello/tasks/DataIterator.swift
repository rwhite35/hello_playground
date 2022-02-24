//
//  DataIterator.swift
//  Hello
//
//  define the structure for a unit of work, in a sequence of operations.
//
//  conforms to AsynIteratorProtocol and provides a return type
//  for objects that call AsyncSequece.makeAsyncIterator method.
//
//  see https://developer.apple.com/documentation/swift/asynciteratorprotocol
//
//  Created by Ron White on 2/24/22.
//

import Foundation

struct DataIterator: AsyncIteratorProtocol {
    
    /// the return type for this unit of work
    typealias Element = Data
    
    /// the index for this unit of work
    /// will be incremented by 1 with each (next) sequence
    private var index = 0
    
    /// a shared URLSession property
    private let urlSession = URLSession.shared
    
    /// URLs received from AsyncSequence.makeAsyncIterator
    let urls: [URL]
    
    /// constructor
    init(urls: [URL]) { self.urls = urls }
    
    /// next() method performs a unit of work in a sequence of operations
    ///  additionally, DataIterator structure is immutable due to its a reference type object
    ///  however, methods can be marked 'mutating' to allow PRIVATE properties to update values.
    mutating func next() async throws -> Data? {
        
        /// check bounds, when nil, all work for a given Task are complete.
        guard index < urls.count else { return nil }
        
        /// get this loops URL and increment index by 1
        let url = urls[index]
        index += 1
        
        /// perform an operation (makes the API call)
        if #available(iOS 15.0, *) {
            let (data, _) = try await urlSession.data(from: url)
            return data
        } else {
            // Fallback on earlier versions
            return nil
        }
    }
    
}
