//
//  RobotViewCell.swift
//  RoboList
//
//  Created by Mykola Denysyuk on 6/17/18.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

import UIKit

class RobotViewCell: UICollectionViewCell {

    @IBOutlet private weak var roboImageView: UIImageView!
    
    func setupWith(name: String, image: UIImage) {
        roboImageView.image = image
    }
}
