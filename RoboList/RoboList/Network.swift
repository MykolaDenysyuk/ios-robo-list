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
    func fetchFewRobots(names: [String], completion: @escaping ([UIImage?]) -> Void)
    func fetchRobot(with name: String, completion: @escaping (UIImage?) -> Void)
}

class Network: RobotRepository {
    
    func fetchFewRobots(names: [String], completion: @escaping ([UIImage?]) -> Void) {
        let updateQueue = DispatchQueue(label: "fetchFewRobots.updateQueue")
        
        var images = [UIImage?]()
        let group = DispatchGroup()
        
        names.forEach { name in
            group.enter()
            fetchRobot(with: name, completion: { image in
                updateQueue.async {
                    images.append(image)
                    group.leave()
                }
            })
        }
        
        group.notify(queue: updateQueue) {
            completion(images)
        }
    }
    
    func fetchRobot(with name: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: "https://robohash.org/\(name)")!
        let dataTask = URLSession(configuration: .default).dataTask(with: url) { (data, _, _) in
            let image: UIImage? = {
                if let data = data {
                    return UIImage(data: data)
                }
                return nil
            }()
            completion(image)
        }
        dataTask.resume()
    }
}
