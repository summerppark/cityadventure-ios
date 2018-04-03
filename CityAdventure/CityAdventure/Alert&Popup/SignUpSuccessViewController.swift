//
//  SignUpSuccessViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 2..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class SignUpSuccessViewController: UIViewController {
    
    var name: String!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = name + " 대원님 가입이 완료되었습니다."
        }
    }
    
    
    @IBOutlet weak var alertBgImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButtonLayout()
    }
    
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertBgImage.snp.trailing).offset(-4)
            make.centerY.equalTo(alertBgImage.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @IBAction func close(sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
        
        
}
