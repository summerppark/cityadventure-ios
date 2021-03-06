//
//  AlertViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit


protocol AlertViewProtocol: class {
    func successAuth()
    func successCallback()
    func successEdit()
}

class AlertviewController : UIViewController {
    
    var alertString: String?
    var delegate: AlertViewProtocol?
    var statusCode: Int?
    
    @IBOutlet weak var alertStringLabel: UILabel! {
        didSet {
            alertStringLabel.text = alertString
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var alertBgImage: UIImageView!
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertBgImage.snp.trailing).offset(-4)
            make.centerY.equalTo(alertBgImage.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @IBAction func dismissAlert(_ sender: Any) {
        self.dismiss(animated: false) {
            // 성공된 케이스 일때는 다음 뷰로 진행한다.
            if let text = self.alertString {
                if text.first == "인" {
                    self.delegate?.successAuth()
                } else if text == "비밀번호가 변경되었습니다. \n다시 로그인 해주세요~" {
                    self.delegate?.successCallback()
                } else if text == "정보가 성공적으로 수정되었습니다." {
                    self.delegate?.successEdit()
                }
            }
        }
    }
}
