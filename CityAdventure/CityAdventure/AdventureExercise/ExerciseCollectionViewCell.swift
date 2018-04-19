//
//  ExerciseCollectionViewCell.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 19..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stageView: UIView! {
        didSet {
            stageView.layer.cornerRadius = 8.0
            stageView.clipsToBounds = true
            stageView.layer.borderWidth = 2.0
            stageView.layer.borderColor = UIColor.placeHolderColor.cgColor
        }
    }
    
    @IBOutlet weak var stageLabel: UILabel!
}
