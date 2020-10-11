//
//  XCTestCase+Extensions.swift
//  RoboBlockerTests
//
//  Created by Marin on 11/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func expect(_ description: String, timeout: Double = 0.2, f: (_ fulfill: @escaping () -> Void) -> Void) {
        
        let expectation = self.expectation(description: description)
        
        f {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
