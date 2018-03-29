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
    
    // button 3개 상태 체크하기위한 토글값
    var toggleBooleans: [Bool] = [false, false, false]
    
    // 모든 약관 동의 버튼
    @IBOutlet weak var allAgreementButton: UIButton!
    // 다음으로 버튼
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
    
    
    // 이미지
    let noncheck = UIImage(named:"noncheck")
    let okCheck = UIImage(named:"auto_login_ok")
    let allAgreement = UIImage(named:"btn_allCheck_agreement")
    let allAgreementOn = UIImage(named:"btn_allCheck_agreementOn")
    let goToNextOn = UIImage(named: "btn_next_On")
    let goToNext = UIImage(named: "btn_next")
    
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
    
    // 각 항목 체크 버튼 눌렀을 때
    @objc func tappedCheck(sender: UIButton) {
        if sender.currentImage == noncheck {
            toggleBooleans[sender.tag] = true
            sender.setImage(okCheck, for: .normal)
        } else {
            sender.setImage(noncheck, for: .normal)
            toggleBooleans[sender.tag] = false
        }
        
        // 체크 상태 체크
        checkStatus()
    }
    
    func checkStatus() {
        if toggleBooleans[0] && toggleBooleans[1] && toggleBooleans[2] {
            // 모든 항목 동의 했을 때 , 다음으로 넘어갈 수 있음
            allAgreementButton.setImage(allAgreementOn, for: .normal)
            goToNextButton.setImage(goToNextOn, for: .normal)
            goToNextButton.isEnabled = true
        } else {
            // 모든 항목 동의하지 않았을 때, 다음으로 넘어갈 수 없음
            allAgreementButton.setImage(allAgreement, for: .normal)
            goToNextButton.setImage(goToNext, for: .normal)
            goToNextButton.isEnabled = false
        }
    }
    
    //모든 약관 동의 버튼 눌렀을 때
    @IBAction func allCheck(_ sender: Any) {
        if toggleBooleans[0] && toggleBooleans[1] && toggleBooleans[2] {
            for index in 0...toggleBooleans.count - 1 {
                toggleBooleans[index] = false
            }
            
            firstCheckIcon.setImage(noncheck, for: .normal)
            secondCheckIcon.setImage(noncheck, for: .normal)
            thirdCheckIcon.setImage(noncheck, for: .normal)
            
            checkStatus()
        } else {
            for index in 0...toggleBooleans.count - 1 {
                toggleBooleans[index] = true
            }
            
            firstCheckIcon.setImage(okCheck, for: .normal)
            secondCheckIcon.setImage(okCheck, for: .normal)
            thirdCheckIcon.setImage(okCheck, for: .normal)
            
            checkStatus()
        }
    }
    
    // 다음으로 버튼 눌렀을 때
    @IBAction func goToNext(_ sender: Any) {
        if let signup_SecondVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewSeccondController") {
            self.navigationController?.pushViewController(signup_SecondVC, animated: true)
        }
    }
    
}
