//
//  Coordinator.swift
//  RoboList
//
//  Created by Mykola Denysyuk on 6/18/18.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    /// Push user to search for more then one robot at once
    func showTryMoreNamesAlert()
    /// Notifies user that nothing can be found with the given query
    func showInvalidQueryAlert()
}

class RobotsCoordinator: Coordinator {
    
    // MARK: Vars
    
    weak var rootController: UIViewController?
    
    // MARK: Initializer
    
    init(controller: UIViewController) {
        self.rootController = controller
    }
    
    // MARK: Actions
    
    func showTryMoreNamesAlert() {
        showAlert(msg: "there is more fun with fetching more then one robo")
    }
    
    func showInvalidQueryAlert() {
        showAlert(msg: "there is no robot to fetch with given string")
    }
    
    func showAlert(msg: String) {
        guard let root = rootController else { fatalError("presenting controller is required") }
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        root.present(alert, animated: true, completion: nil)
    }
    
}
