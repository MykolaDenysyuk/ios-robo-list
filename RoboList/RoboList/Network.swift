//
//  Network.swift
//  Test
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import Foundation
import UIKit

protocol RobotRepository {
  func fetchFewRobots(names: [String], completion: @escaping ([UIImage]) -> Void)
  func fetchRobot(with name: String, completion: @escaping (UIImage) -> Void)
}

class Network: RobotRepository {
  
  // TODO: change this function so it will fetch all images at the same time, not one-by-one
  // but completion should be called only after all images are fetched.
  // Fell free to change whole class as long as it conforms RobotRepository protocol.
  func fetchFewRobots(names: [String], completion: @escaping ([UIImage]) -> Void) {
    var index = 0
    var images = [UIImage]()
    func fetchRobot() {
      self.fetchRobot(with: names[index]) { (image) in
        images.append(image)
        index += 1
        if index < names.count {
          fetchRobot()
        } else {
          completion(images)
        }
      }
    }
    
    fetchRobot()
  }
  
  // TODO: prevent it from crashing!
  // propose error handling
  func fetchRobot(with name: String, completion: @escaping (UIImage) -> Void) {
    let url = URL(string: "https://robohash.org/\(name)")!
    let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, _, _) in
      completion(UIImage(data: data!)!)
    }
    dataTask.resume()
  }
}
