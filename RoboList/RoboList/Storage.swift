//
//  Storage.swift
//  RoboList
//
//  Created by Mykola Denysyuk on 6/18/18.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

protocol Storage {
    /// Retrieves all models from a persistence store
    func fetch(complete: @escaping ([RoboModel]) -> Void)
    
    /// Save given models to a persistence store
    func save(models: [RoboModel], complete: @escaping () -> Void)
}

class UserDefaultStorage: Storage {
    let key = "UserDefaultStorage.Robots"
    
    func fetch(complete: @escaping ([RoboModel]) -> Void) {
        if let result = UserDefaults.standard.array(forKey: key) as? [[String: Data]] {
            let robots = result.compactMap { (dict) -> RoboModel? in
                guard
                    let name = dict.keys.first,
                    let data = dict.values.first,
                    let image = UIImage(data: data)
                    else { return nil }
                
                return RoboModel(name: name, image: image)
            }
            complete(robots)
        }
        else {
            complete([])
        }
    }
    
    func save(models: [RoboModel], complete: @escaping () -> Void) {
        let raw = models.map { [$0.name: UIImagePNGRepresentation($0.image)] }
        UserDefaults.standard.set(raw, forKey: key)
        UserDefaults.standard.synchronize()
        complete()
    }
}
