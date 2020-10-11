//
//  RoboBlockerTests.swift
//  RoboBlockerTests
//
//  Created by Marin on 05/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import XCTest
@testable import RoboBlocker

class BlockListViewModelTests: XCTestCase {
    
    // MARK: - Test Object
    
    var viewModel: BlockListViewModel!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        viewModel = BlockListViewModel(PersistenceServiceMock())
    }
    
    func testGetContactListStatus() {
        XCTAssertFalse(viewModel.getContactListStatus())
    }
    
    func testSetContactListStatus() {
        viewModel.setContactListStatus(isOn: true)
        XCTAssertTrue(viewModel.getContactListStatus())
    }
    
    func testAddToBlockListRefreshesList() {

        expect("onChangedList called") { fulfil in
            viewModel.onChangedList = {
                fulfil()
            }

            viewModel.addToBlockList(number: "385981111111")
        }
    }
    
    func testDeleteFromBlockListRefreshesList() {

        expect("onChangedList called") { fulfil in
            viewModel.onChangedList = {
                fulfil()
            }

            viewModel.delete(index: 0)
        }
    }
    
    func testAddToBlockList() {
        viewModel.addToBlockList(number: "385982222222")
        XCTAssertTrue(viewModel.blockList.contains("385982222222"))
    }
    
    func testDeleteFromBlockList() {
        viewModel.delete(index: 0)
        XCTAssertTrue(viewModel.blockList.isEmpty)
    }
}
