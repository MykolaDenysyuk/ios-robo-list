//
//  RoboLibrary.swift
//  Test
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

class RoboLibrary {
    private var robots: [RoboModel]
    init() {
        self.robots = []
        //TODO: finish this so it pass tests
      }
  
    var roboCount: Int {
        return robots.count
      
    }
  
    var newestRobot: RoboModel? {
        return robots.last
    }
  
    func addRobo(name: String, image: UIImage) {
    //TODO: finish this so it pass tests
    }
  
    func reset()
    {
    //TODO: finish this so it pass tests
    }
  
    struct RoboModel {
    let name: String
    let image: UIImage }
}
