//
//  HintPopViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

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
    
    var hintString: String = ""
    
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
    @IBOutlet weak var hintLabel: UILabel!
    
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
    
    @objc func tappedYesButton() {
        firstView.isHidden = true
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


