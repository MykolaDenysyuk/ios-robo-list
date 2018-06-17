//
//  RoboLibrary.swift
//  Test
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

class RoboLibrary {
    
    // MARK: Vars
    
    private var robots = [RoboModel]()
    var roboCount: Int { return robots.count }
    var newestRobot: RoboModel? { return robots.last }
    
    // MARK: Actions
    
    func addRobo(name: String, image: UIImage) {
        if let index = robots.index(where: { $0.name == name }) {
            let existing = robots[index]
            robots.remove(at: index)
            robots.append(existing)
        }
        else {
            robots.append(RoboModel(name: name, image: image))
        }
    }
    
    func reset() {
        robots.removeAll()
    }
    
    struct RoboModel {
        let name: String
        let image: UIImage
    }
}
