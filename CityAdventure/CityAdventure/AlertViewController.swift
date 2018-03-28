//
//  AlertViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class AlertviewController : UIViewController {
    
    var alertString: String?
    
    @IBOutlet weak var alertStringLabel: UILabel! {
        didSet {
            alertStringLabel.text = alertString
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var alertBgImage: UIImageView!
    
    override func viewDidLoad() {
        
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertBgImage.snp.trailing).offset(-4)
            make.centerY.equalTo(alertBgImage.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @IBAction func dismissAlert(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
