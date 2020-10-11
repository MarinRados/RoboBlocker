//
//  GuardViewModelTests.swift
//  RoboBlockerTests
//
//  Created by Marin on 11/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import XCTest
@testable import RoboBlocker

class GuardViewModelTests: XCTestCase {
    
    // MARK: - Test Object
    
    var viewModel: GuardViewModel!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        viewModel = GuardViewModel(PersistenceServiceMock())
    }
    
    func testGetGuardStatus() {
        XCTAssertFalse(viewModel.getGuardStatus())
    }
    
    func testSetGuardStatus() {
        viewModel.setGuardStatus(isOn: true)
        XCTAssertTrue(viewModel.getGuardStatus())
    }
    
    func testAddToFilterListRefreshesList() {

        expect("onChangedList called") { fulfil in
            viewModel.onChangedList = {
                fulfil()
            }

            viewModel.addToFilter(word: "lottery")
        }
    }
    
    func testDeleteFromFilterListRefreshesList() {

        expect("onChangedList called") { fulfil in
            viewModel.onChangedList = {
                fulfil()
            }

            viewModel.delete(index: 0)
        }
    }
    
    func testAddToFilterList() {
        viewModel.addToFilter(word: "winnings")
        XCTAssertTrue(viewModel.filteredWords.contains("winnings"))
    }
    
    func testDeleteFromBlockList() {
        viewModel.delete(index: 0)
        XCTAssertTrue(viewModel.filteredWords.count == 1)
    }
}
