//
//  BoxcastTest.swift
//  HelloTests
//
//  Created by Ron White on 1/5/22.
//

import XCTest
@testable import Hello

class BoxcastTest: XCTestCase {

    var boxcast: Boxcast!
    let testString = "Bill"
    
    // setup for each use case test
    override func setUp() {
        super.setUp()
        boxcast = Boxcast(string: testString)
    }
    
    // tear down each use case test
    // when a function has state, unwind the state
    // otherwise set functions to nil
    override func tearDown() {
        super.tearDown()
        boxcast = nil
    }
    
    // test case 1: username is valid and should not throw an error
    func test_is_validate_username() throws {
        // expecting the expression to be true and does not throw
        XCTAssertNoThrow(try boxcast.validateUserName(testString))
    }
    
    // test case 2: username is nil and should throw an error
    func test_is_nil_username() throws {
        XCTAssertThrowsError(try boxcast.validateUserName(nil))
    }
    
    // test case 3: username is to short and should throw an error
    func test_is_short_username() throws {
        let short = String(testString.prefix(2))
        XCTAssertThrowsError(try boxcast.validateUserName(short))
    }

}
