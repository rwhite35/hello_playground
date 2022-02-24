//
//  DataSequence.swift
//  Hello
//
//  conforms to AsyncSequence protocol type providing asynchronous,
//  sequential, iterated access to its elements.  Similar to Sequence type
//  normally used in DispatchGroups, this performs more than one
//  operation - typically API calls.
//
//  AsyncSequence check for 'thread safety' meaning all dependency should be 'thread safe'.
//
//  see https://developer.apple.com/documentation/swift/asyncsequence
//  see https://developer.apple.com/documentation/swift/swift_standard_library/concurrency
//
//  JSONPlaceholder endpoint: https://jsonplaceholder.typicode.com/photos
//  this is a read only resource of 5000 photos. its structure looks like
//  [
//    {
//      "albumId": 1,
//      "id": 1,
//      "title": "accusamus beatae ad facilis cum similique qui sunt",
//      "url": "https://via.placeholder.com/600/92c952",
//      "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//    },...,
//  ]
//
//  Created by Ron White on 2/24/22.
//
import Foundation

/// define a constant url string for testing
/// let urlString = "https://jsonplaceholder.typicode.com/photos"

struct DataSequence: AsyncSequence {
    
    /// the return type from DataIterator
    typealias Element = Data
    
    /// an indexed collection of sequencial URL to be requested
    let urls: [URL]
    
    /// construct the object from some task
    init(urls: [URL]) {
        self.urls = urls
    }
    
    /// creates the asynchronous iterator that produces
    /// the elements for this sequence of work.
    ///  - Returns: instance of the AsyncIterator 
    func makeAsyncIterator() -> DataIterator {
        return DataIterator(urls: urls)
    }
    
}
