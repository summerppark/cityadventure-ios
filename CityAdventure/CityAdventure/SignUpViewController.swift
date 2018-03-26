//
//  SignUpViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 25..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let attributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 12.0),
                             NSAttributedStringKey.foregroundColor : UIColor.textView_gray_Color
    ]
    
    @IBOutlet weak var headerToolbar: UIView!
    @IBOutlet weak var headerToolbarHeight: NSLayoutConstraint!
    
    // button 3개 상태 체크하기위한 토클값
    var toggleBooleans: [Bool] = [false, false, false]
    
    
    
    @IBOutlet weak var allAgreementButton: UIButton!
    @IBOutlet weak var goToNextButton: UIButton!
    
    
    
    @IBOutlet var textViewHeights: [NSLayoutConstraint]!
    
    @IBOutlet weak var firstTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: firstTextView.text, attributes: attributedString)
            firstTextView.attributedText = attString
            self.firstTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    @IBOutlet weak var secondTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: secondTextView.text, attributes: attributedString)
            secondTextView.attributedText = attString
            self.secondTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    @IBOutlet weak var thirdTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: thirdTextView.text, attributes: attributedString)
            thirdTextView.attributedText = attString
            self.thirdTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    // 첫번째 체크 아이콘
    @IBOutlet weak var firstCheckIcon: UIButton! {
        didSet {
            firstCheckIcon.tag = 0
            firstCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    // 두번째 체크 아이콘
    @IBOutlet weak var secondCheckIcon: UIButton! {
        didSet {
            secondCheckIcon.tag = 1
            secondCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    // 세번째 체크 아이콘
    @IBOutlet weak var thirdCheckIcon: UIButton! {
        didSet {
            thirdCheckIcon.tag = 2
            thirdCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        layoutCheck()
        // edge gesture set
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    
    // iPhone X 상단 바 높이 조정
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerToolbarHeight.constant = 88
        }
        
        if Constants.DeviceType.IS_IPHONE_X || Constants.DeviceType.IS_IPHONE_6P {
            textViewHeights.forEach({ height in
                height.constant = 160
            })
        }
        
    }
    
    // 뒤로가기 버튼 눌렀을 때
    @IBAction func tappedBackbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // tapped leftBarButton
    @objc func tappedCheck(sender: UIButton) {
        if sender.currentImage == UIImage(named: "noncheck") {
            toggleBooleans[sender.tag] = true
            sender.setImage(UIImage(named:"auto_login_ok"), for: .normal)
        } else {
            sender.setImage(UIImage(named:"noncheck"), for: .normal)
            toggleBooleans[sender.tag] = false
        }
        
        
        if toggleBooleans[0] && toggleBooleans[1] && toggleBooleans[2] {
            allAgreementButton.setImage(UIImage(named:"btn_allCheck_agreementOn"), for: .normal)
        } else {
            allAgreementButton.setImage(UIImage(named:"btn_allCheck_agreement"), for: .normal)
        }
        
    }
}
