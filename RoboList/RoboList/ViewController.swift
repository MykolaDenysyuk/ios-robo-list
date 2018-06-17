//
//  ViewController.swift
//  Test
//
//  Created by Michał Papp on 20.05.2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Vars
    
    private let cellReuseIdentifier = "cell"
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roboNameContainer: UIView!
    @IBOutlet weak var roboNameField: UITextField!
    private var robotNameText: String { return roboNameField.text ?? "" }
    let robodex = RoboLibrary(storage: UserDefaultStorage())
    var fetcher: Fetcher = RobotsFetcher()
    lazy var coordinator: Coordinator = {
       return RobotsCoordinator(controller: self)
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        roboNameField.delegate = self
        view.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicator.startAnimating()
        robodex.retrieveFromStorage {
            self.collectionView.reloadData()
            self.loadingIndicator.stopAnimating()
        }
    }
    
    // MARK: Actions
    
    @IBAction func start() {
        roboNameField.resignFirstResponder()
        loadingIndicator.startAnimating()
        
        let result = fetcher.fetch(query: robotNameText) {[weak self] models in
            guard let sself = self else { return }
            DispatchQueue.main.async {
                sself.reloadWith(models)
            }
        }
        if result == 1 {
           coordinator.showTryMoreNamesAlert()
        }
        else if result == 0 {
            coordinator.showInvalidQueryAlert()
            loadingIndicator.stopAnimating()
        }
    }
    
    func reloadWith(_ models: ([RoboModel])) {
        models.forEach { robodex.addRobo($0) }
        collectionView.reloadData()
        loadingIndicator.stopAnimating()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return robodex.roboCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier,
                                                          for: indexPath) as? RobotViewCell
            else { fatalError("RobotViewCell is expected") }
        
        let robot = robodex[indexPath.row]
        cell.setupWith(name: robot.name, image: robot.image)
        return cell
    }
}
