//
//  ClientCenterViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class ClientCenterViewController: UIViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
   
    @IBOutlet weak var backGroundView2: UIView! {
        didSet {
            backGroundView2.layer.cornerRadius = 8.0
            backGroundView2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet {
            backGroundView.layer.cornerRadius = 8.0
            backGroundView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userEmail: UILabel! {
        didSet {
            if let email = DataManager.shared.userAccountInfo?.userAccountInfo?.s_email {
                userEmail.text = email
            }
        }
    }
    
    
    @IBOutlet weak var backGroundView3: UIView! {
        didSet {
            backGroundView3.layer.cornerRadius = 8.0
            backGroundView3.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            let contentHeight = textView.contentSize.height
            let offSet = textView.contentOffset.y
            let contentOffset = contentHeight - offSet
            textView.contentOffset = CGPoint(x: 0,y: -contentOffset)
            textView.font = UIFont(name: "GodoM", size: 16.0)
            textView.delegate = self
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
}



extension ClientCenterViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = UIColor.black
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == "" {
            textView.textColor = UIColor.placeHolderColor
            textView.text = "문의 내용을 상세히 보내주시면 더욱 빨리 답변이 가능합니다!"
        }
        
        return true
    }
}
