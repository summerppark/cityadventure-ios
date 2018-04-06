//
//  RetryAuthAlertViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class RetryAuthAlertViewController: BaseViewController {
    
    @IBOutlet weak var close: UIButton! {
        didSet {
            close.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var alertView: UIView! {
        didSet {
            self.alertView.layer.cornerRadius = 16.0
            self.alertView.clipsToBounds = true
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButtonLayout()
   
    }
    
    
    func closeButtonLayout() {
        close.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertView.snp.trailing).offset(-4)
            make.centerY.equalTo(alertView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @objc func closeAlert() {
        self.dismiss(animated: false, completion: nil)
    }
}
