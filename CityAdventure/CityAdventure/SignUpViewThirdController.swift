//
//  SignUpViewThirdController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class SignupViewThirdController: UIViewController {
    
    // 헤더뷰
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    
    
    // 이름 텍스트필드
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    
    // 남자
    @IBOutlet weak var maleCheckImage: UIImageView!
    @IBOutlet weak var maleButton: UIButton! {
        didSet {
            maleButton.addTarget(self, action: #selector(genderSelect), for: .touchUpInside)
        }
    }
    
    // 여자
    @IBOutlet weak var femaleCheckImage: UIImageView!
    @IBOutlet weak var femaleButton: UIButton! {
        didSet {
            femaleButton.addTarget(self, action: #selector(genderSelect), for: .touchUpInside)
        }
    }
    
    // 생일 텍스트 필드 -> 데이트피커
    @IBOutlet weak var birthdayTextField: UITextField!
    
    
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.addTarget(self, action: #selector(deleteName), for: .touchUpInside)
        }
    }
    
    
    // City 입력 컨스트레인트
    @IBOutlet weak var cityTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityHeight: NSLayoutConstraint!
    @IBOutlet weak var cityLabelTopConstraint: NSLayoutConstraint!
    
    
    let checkOn = UIImage(named: "btn_checkOn_gender")
    let checkOff = UIImage(named: "btn_check_gender")
    
    let checkedAttributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 18.0),
                             NSAttributedStringKey.foregroundColor : UIColor.black
    ]
    
    let attributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 13.0),
                                     NSAttributedStringKey.foregroundColor : UIColor.buttonTitleColor
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    
    // 성별 누를때 마다
    @objc func genderSelect(sender: UIButton) {
        if sender.tag == 0 {
            makeAttributedString(toggle: true)
        } else {
            makeAttributedString(toggle: false)
        }
    }
    
    // X 버튼 눌렀을 때
    @objc func deleteName() {
        nameTextField.text = ""
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
        }
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            cityTopConstraint.constant = 42
            cityHeight.constant = 260
            cityLabelTopConstraint.constant = 12
        }
        
    }
    
    
    
    // 성별 선택 로직
    func makeAttributedString(toggle: Bool) {
        maleCheckImage.image = toggle ? checkOn : checkOff
        femaleCheckImage.image = !toggle ? checkOn : checkOff
        let type = toggle ? checkedAttributedString : attributedString
        let type2 = toggle ? attributedString : checkedAttributedString
        maleButton.setAttributedTitle(NSAttributedString(string: (maleButton.titleLabel?.text)!, attributes: type), for: .normal)
        femaleButton.setAttributedTitle(NSAttributedString(string: (femaleButton.titleLabel?.text)!, attributes: type2), for: .normal)
     
    }
}


extension SignupViewThirdController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            deleteButton.isHidden = false
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            deleteButton.isHidden = true
        }
        return true
    }
    
    // nameTextField 만 4자리까지 입력 가능하도록 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            let newLength = (textField.text?.count)! + string.count - range.length
            return !(newLength > 4)
        }
        return true
    }
}
