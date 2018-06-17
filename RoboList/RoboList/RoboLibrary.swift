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
    
    let storage: Storage
    private var robots = [RoboModel]()
    var roboCount: Int { return robots.count }
    var newestRobot: RoboModel? { return robots.last }
    
    // MARK: Initializer
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: Actions
    
    func retrieveFromStorage(complete: @escaping () -> Void) {
        storage.fetch { (models) in
            self.robots = models
            complete()
        }
    }
    
    func addRobo(name: String, image: UIImage) {
        addRoboIfNeeded(name: name, model: RoboModel(name: name, image: image))
    }
    
    func addRobo(_ model: RoboModel) {
        addRoboIfNeeded(name: model.name, model: model)
    }
    
    /// If model with given name is in the list, it is moved to the end.
    /// otherwise the new given model is appended
    private func addRoboIfNeeded(name: String, model: @autoclosure () -> RoboModel) {
        if let index = robots.index(where: { $0.name == name }) {
            let existing = robots[index]
            robots.remove(at: index)
            robots.append(existing)
        }
        else {
            robots.append(model())
        }
        
        storage.save(models: robots, complete: {})
    }
    
    func reset() {
        robots.removeAll()
    }
    
    subscript(index: Int) -> RoboModel {
        return robots[index]
    }
}

struct RoboModel {
    let name: String
    let image: UIImage
}
