//
//  HintPopViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit
import Toaster
import Alamofire

class HintPopViewController: BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var yesButton: UIButton! {
        didSet {
            yesButton.layer.cornerRadius = 8.0
            yesButton.clipsToBounds = true
            yesButton.layer.borderWidth = 4.0
            yesButton.layer.borderColor = UIColor.black.cgColor
            yesButton.addTarget(self, action: #selector(tappedYesButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var noButton: UIButton! {
        didSet {
            noButton.layer.cornerRadius = 8.0
            noButton.clipsToBounds = true
            noButton.layer.borderWidth = 4.0
            noButton.layer.borderColor = UIColor.black.cgColor
            noButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var hintView: UIView! {
        didSet {
            hintView.layer.cornerRadius = 8.0
            hintView.clipsToBounds = true
        }
    }
    
    var hintString: String?
    
    @IBOutlet weak var noticeLabel: UILabel! {
        didSet {
            let formattedString = NSMutableAttributedString()
            formattedString
                .normal("코인 ")
                .bold("300")
                .normal("개를 사용해서 힌트를 보시겠습니까?")
            noticeLabel.attributedText = formattedString
            
        }
    }
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var hintLabel: UILabel! {
        didSet {
            hintLabel.text = hintString
        }
    }
    
    override func viewDidLoad() {
        closeButtonLayout()
    }
    
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(hintView.snp.trailing).offset(-4)
            make.centerY.equalTo(hintView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    var hintText: String?
    
    
    @objc func tappedYesButton() {
  
        super.showLoading(view: self.view)
        
        
        if let myCoin = DataManager.shared.userInfo?.userInfo?.ui_credit, myCoin >= 300, let token = UserDefaults.standard.object(forKey: "token") as? String {
            
            Alamofire.request(APIUrls.hintExpCoin(token: token), method: .post, parameters: nil, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                guard let statusCode = response.response?.statusCode else {
                    Toast.init(text: "다시 시도해 주세요.").show()
                    return
                }
                
                switch statusCode {
                case 200 :
                    if let result = response.result.value as? NSDictionary, let data = result["data"] as? NSDictionary, let credit = data["ui_credit"] as? Int, let exp = data["ui_exp"] as? Int {
                        DataManager.shared.userInfo?.userInfo?.ui_credit = credit
                        DataManager.shared.userInfo?.userInfo?.ui_exp = exp
                    }
                    self.firstView.isHidden = true
                    self.hintLabel.isHidden = false
                    self.hintLabel.text = self.hintString
                    super.hideLoading()
                default :
                    Toast.init(text: "다시 시도해 주세요.").show()
                    super.hideLoading()
                    break
                }
            })
            
        } else {
            
            Toast.init(text: "코인이 부족합니다.").show()
            super.hideLoading()
        }
    }
    
    @objc func tappedCloseButton() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}


