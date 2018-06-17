//
//  TestTests.swift
//  TestTests
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import XCTest
@testable import RoboList

class RoboLibraryTests: XCTestCase {
  
  let library = RoboLibrary()
  
  override func setUp() {
    super.setUp()
    library.reset()
  }
  
  func testAddOneRobotToEmptyLibrary() {
    library.addRobo(name: "name", image: UIImage())
    
    XCTAssertEqual(library.roboCount, 1, "There should be one robot in the library.")
  }
  
  
  func testAddTwoDifferentRobotsToEmptyLibrary() {
    library.addRobo(name: "name1", image: UIImage())
    library.addRobo(name: "name2", image: UIImage())

    XCTAssertEqual(library.roboCount, 2, "There should be two robots in the library.")
  }

  func testAddTwoSameRobotsToEmptyLibrary() {
    library.addRobo(name: "name1", image: UIImage())
    library.addRobo(name: "name1", image: UIImage())
    
    XCTAssertEqual(library.roboCount, 1, "There should be one robot in the library.")
  }
  
  func testNewestRobot() {
    library.addRobo(name: "name1", image: UIImage())
    library.addRobo(name: "name2", image: UIImage())
    library.addRobo(name: "name3", image: UIImage())
    
    XCTAssertEqual(library.newestRobot?.name, "name3", "Last added robot should be newest one.")
  }

  func testNewestRobotWithEmptyLibrary() {
    XCTAssertNil(library.newestRobot, "There shouldn't be newest robot in empty library.")
  }

  func testNewestRobotWithTheSameRobot() {
    library.addRobo(name: "name1", image: UIImage())
    library.addRobo(name: "name2", image: UIImage())
    library.addRobo(name: "name3", image: UIImage())
    library.addRobo(name: "name2", image: UIImage())

    XCTAssertEqual(library.newestRobot?.name, "name2", "Last updated robot should be newest one.")
  }

  func testResetLibrary() {
    library.addRobo(name: "name", image: UIImage())
    
    library.reset()
    
    XCTAssertEqual(library.roboCount, 0, "Reseting library should remove all robots from it.")
  }

  
}
