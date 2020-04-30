//
//  TestAssignmentTests.swift
//  TestAssignmentTests
//
//  Created by Abhishek Singla on 29/04/20.
//  Copyright © 2020 Abhishek Singla. All rights reserved.
//

import XCTest
@testable import TestAssignment

class TestAssignmentTests: XCTestCase {

    let viewModel = CountryVM()
    override func setUp() {

    }

    func testVM() {
        viewModel.loadData()

        XCTAssertEqual(viewModel.factsCount, 13)

        XCTAssertNotEqual(viewModel.name, "")
        XCTAssertNotEqual(viewModel.factTitle(0), "")

        XCTAssertNotEqual(viewModel.description(0), "")
        XCTAssertEqual(viewModel.description(1), "")
    }

}
