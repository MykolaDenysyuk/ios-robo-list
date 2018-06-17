//
//  RobotsFetcher.swift
//  RoboList
//
//  Created by Mykola Denysyuk on 6/18/18.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit


protocol Fetcher {
    
    /// Fetches robots images for given query
    ///
    /// - Parameters:
    ///   - query: contains list of one or more robots names
    ///   - dialog: 
    ///   - completion: list of tuples, each contains robot's name and image
    /// - Returns: expected number of robots to be fetched
    func fetch(query: String, completion: @escaping ([RoboModel]) -> Void) -> Int
}

class RobotsFetcher: Fetcher {
    
    // MARK: Vars
    
    private let separators: [String]
    private let repository: RobotRepository
    
    // MARK: Initializer
    
    init(separators: [String] = [",", "."], repository: RobotRepository = Network()) {
        self.separators = separators
        self.repository = repository
    }
    
    // MARK: Actions
    
    /// Breaks given string into list of robots' names separated by separators
    func breakIntoNames(_ text: String) -> [String] {
        guard !text.isEmpty else { return [] }
        
        let preparedText = text.replacingOccurrences(of: " ", with: "")
        
        var separators = self.separators
        
        func namesFrom(string: String, separator: String?) -> [String] {
            guard let separator = separator else { return [string] }
            let nextSeparator = separators.popLast()
            let result = string.components(separatedBy: separator)
                .flatMap { namesFrom(string: $0, separator: nextSeparator) }
            return result
        }
        
        return namesFrom(string: preparedText, separator: separators.popLast())
    }
    
    func fetch(query: String, completion: @escaping ([RoboModel]) -> Void) -> Int {
        let names = breakIntoNames(query)
        repository.fetchFewRobots(names: names) { (images) in
            let models = images.enumerated().compactMap {
                guard let image = $0.element else { return nil }
                return RoboModel(name: names[$0.offset],
                                 image: image)
            } as [RoboModel]
            completion(models)
        }
        return names.count
    }
}
