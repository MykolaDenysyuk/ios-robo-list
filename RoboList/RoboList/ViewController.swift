//
//  ViewController.swift
//  Test
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  typealias RoboName = String
  
  override func viewDidLoad() {
    super.viewDidLoad()
    roboNameField.delegate = self
    view.backgroundColor = .gray
  }
  
  @IBOutlet weak var roboImages: UIStackView!
  @IBOutlet weak var roboNameField: UITextField!
  let robodex = RoboLibrary()// TODO: make it persistent not in-memory only
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    start()// TODO: add button to featch robot images instead of fetching it when focus is lost on text field
  }

  // TODO: clean this function,
  func start() {
    // TODO: use also "." and ";" as separators
    let r = roboNameField.text!.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
    if r.count > 1 {
      // TODO: make it fetch only robots that wasn't featch previously
      var i=0
      Network().fetchFewRobots(names: r) { $0.forEach({ (image) in
          self.robodex.addRobo(name: r[i], image: image)
          i+=1
          let roboImage = UIImageView(image: image)
          roboImage.contentMode = .scaleAspectFit
          self.roboImages.addArrangedSubview(roboImage) })
      }
    } else if r.count == 1 {
      //TODO: DISPLAY AN ALERT that there is more fun with fetching more then one robo, then FETCH and DISPLAY a robot.
    } else {
      // TODO: DISPLAY AN ALERT that there is no robot to fetch with given string.
      // DISPLAY random number of already fetched robots (if there are any).
    }
  }
}
