//
//  MOONMenusTests.swift
//  MOONMenusTests
//
//  Created by 月之暗面 on 2020/2/15.
//  Copyright © 2020 月之暗面. All rights reserved.
//

import XCTest
@testable import MOONMenus

class MOONMenusTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        AppDelegate().configAttrs(string: "test for moon. Other test for Moon.")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
