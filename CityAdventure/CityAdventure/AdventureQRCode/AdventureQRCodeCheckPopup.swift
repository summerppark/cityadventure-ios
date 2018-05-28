//
//  AdventureQRCodeCheckPopup.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 25..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class AdventureQRCodeCheckPopup: UIViewController {
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButtonLayout()
    }
    
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertView.snp.trailing).offset(-4)
            make.centerY.equalTo(alertView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @IBAction func hidePopup(sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
