//
//  CoordinatesTests.swift
//  
//
//  Created by Kamaal Farah on 09/12/2022.
//

import XCTest
@testable import AOC2022

final class CoordinatesTests: XCTestCase {
    func testAreTouching() {
        XCTAssert(Coordinates(x: 0, y: 0).areTouching(Coordinates(x: 0, y: 0)))
        XCTAssert(Coordinates(x: 5, y: 3).areTouching(Coordinates(x: 5, y: 2)))
        XCTAssert(Coordinates(x: 1, y: 2).areTouching(Coordinates(x: 2, y: 1)))
    }

    func testAreNotTouching() {
        XCTAssertFalse(Coordinates(x: 0, y: 0).areTouching(Coordinates(x: 2, y: 0)))
        XCTAssertFalse(Coordinates(x: 5, y: 3).areTouching(Coordinates(x: 5, y: 5)))
        XCTAssertFalse(Coordinates(x: 1, y: 2).areTouching(Coordinates(x: 3, y: 1)))
        XCTAssertFalse(Coordinates(x: 1, y: 2).areTouching(Coordinates(x: 1, y: 20)))
    }
}
