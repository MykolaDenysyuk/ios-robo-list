//
//  RobotsFetcherTests.swift
//  RoboListTests
//
//  Created by Mykola Denysyuk on 6/18/18.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import XCTest
@testable import RoboList

class RobotsFetcherTests: XCTestCase {
    
    func testBreakIntoNamesEmptyText() {
        let fetcher = RobotsFetcher()
        let text = ""
        
        let result = fetcher.breakIntoNames(text)
        
        XCTAssert(result.isEmpty, "there should not be any name")
    }
    
    func testBreakIntoNamesSingleSeparator() {
        let fetcher = RobotsFetcher(separators: [","])
        let text = "red, green, blue"
        
        let result = fetcher.breakIntoNames(text)
        
        XCTAssert(result.count == 3, "3 names expected")
        XCTAssertEqual(result[0], "red")
        XCTAssertEqual(result[1], "green")
        XCTAssertEqual(result[2], "blue")
    }
    
    func testBreakIntoNamesMultipleSeparators() {
        let fetcher = RobotsFetcher(separators: [",", ";", "&"])
        let text = "red, green; blue& brown"
        
        let result = fetcher.breakIntoNames(text)
        
        XCTAssert(result.count == 4, "4 names expected")
        XCTAssertEqual(result[0], "red")
        XCTAssertEqual(result[1], "green")
        XCTAssertEqual(result[2], "blue")
        XCTAssertEqual(result[3], "brown")
    }
    
    func testBreakIntoNamesExtraSeparators() {
        let fetcher = RobotsFetcher(separators: [",", ";", "&", "AND", "OR"])
        let text = "red, green; blue& brown"
        
        let result = fetcher.breakIntoNames(text)
        
        XCTAssert(result.count == 4, "4 names expected")
        XCTAssertEqual(result[0], "red")
        XCTAssertEqual(result[1], "green")
        XCTAssertEqual(result[2], "blue")
        XCTAssertEqual(result[3], "brown")
    }
    
    func testFetch() {
        let repository = TestRobotsRepository()
        let fetcher = RobotsFetcher(separators: [","], repository: repository)
        let query = "red, grey, black"
        
        let result = fetcher.fetch(query: query, completion: {_ in})
        
        XCTAssert(result == 3)
        switch repository.isCalled {
        case .fetchFewRobots(let names):
            XCTAssertEqual("red", names[0])
            XCTAssertEqual("grey", names[1])
            XCTAssertEqual("black", names[2])
        default:
            XCTFail("fetchFewRobots method is expected to be called")
        }
    }
}

class TestRobotsRepository: RobotRepository {
    
    enum IsCalled {
        case none
        case fetchRobot(String)
        case fetchFewRobots([String])
    }
    
    private(set) var isCalled = IsCalled.none
    
    func fetchRobot(with name: String, completion: @escaping (UIImage) -> Void) {
        isCalled = .fetchRobot(name)
    }
    
    func fetchFewRobots(names: [String], completion: @escaping ([UIImage]) -> Void) {
        isCalled = .fetchFewRobots(names)
    }
    
}
