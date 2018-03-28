//
//  SignUpViewSeccondController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewSeccondController: UIViewController {

    //헤더뷰 높이
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    //배경 뷰 높이
    @IBOutlet weak var login_bg_height: NSLayoutConstraint!
    
    // 로그인 정보 레이블 컨스트레인트
    @IBOutlet weak var loginLabelHeight: NSLayoutConstraint!
    
    // 프로필 등록 컨스트레인트
    @IBOutlet weak var profileLabelHeight: NSLayoutConstraint!

    // 디바이스별로 공간을 넓히기 위한 컨스트레인트
    @IBOutlet weak var topconst1: NSLayoutConstraint!
    @IBOutlet weak var topconst3: NSLayoutConstraint!
    
    // 첫번째 입력 부분 - 이메일 입력
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var emailDeleteButton: UIButton!
    @IBOutlet weak var duplicatedCheckButton: UIButton!
    
    // 두번째 입력 부분 - 이메일 재입력
    @IBOutlet weak var retryEmailTextField: UITextField! {
        didSet {
            retryEmailTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var retryEmailTextFieldStatus: UILabel!
    @IBOutlet weak var retryEmailBorder: UIImageView!
    
    @IBOutlet weak var retryEmailDeleteButton: UIButton!
    
    // 3번째 입력 부분 - 비밀번호 입력
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var passwordDeleteButton: UIButton!
    @IBOutlet weak var passwordTextFieldStatus: UILabel!
    @IBOutlet weak var passwordBorder: UIImageView!
    
    // 4번재 입력 부분 - 비밀번호 재입력
    @IBOutlet weak var retryPasswordTextField: UITextField! {
        didSet {
            retryPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var retryPasswordTextFieldStatus: UILabel!
    @IBOutlet weak var retryPasswordDeleteButton: UIButton!
    @IBOutlet weak var retryPasswordBorder: UIImageView!
    
    // 다음으로 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    // 텍스트필드 배열
    var textFields: [UITextField] = []
    var deleteButtons: [UIButton] = []
    var statuslabels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 텍스트필드 배열
        
        textFields = [emailTextField, retryEmailTextField, passwordTextField, retryPasswordTextField]
        
        deleteButtons = [emailDeleteButton, retryEmailDeleteButton, passwordDeleteButton, retryPasswordDeleteButton]
        
        statuslabels = [retryEmailTextFieldStatus, passwordTextFieldStatus, retryPasswordTextFieldStatus]
       
        textFields.forEach { (tf) in
            tf.delegate = self
        }
        
        
        layoutCheck()

    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
            
            // iPhone X 일 때 레이아웃
           
        }
        
        // iPhoneX ,plus 일 때 레이아웃
        // 배경 높이 올려주고 레이블 컨스트레인트조정
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            login_bg_height.constant = 380
            loginLabelHeight.constant = 8
            profileLabelHeight.constant = 8
            topconst1.constant = 18
            topconst3.constant = 18
    
        }
    }
    
    
    
    
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        print(sender.tag)
    }
}


extension SignUpViewSeccondController: UITextFieldDelegate {
    
    
    // 입력값에 따른 상태 체크
    @objc func textFieldDidChange(sender: UITextField) {
        deleteButtons[sender.tag].isHidden = false
        // 이메일 + 이메일 재입력
        if sender.tag == 1 || (sender.tag == 0 && !(retryEmailTextField.text?.isEmpty)!) {
            if emailTextField.text == retryEmailTextField.text {
                retryEmailTextFieldStatus.isHidden = false
                retryEmailTextFieldStatus.textColor = UIColor.status_ok_Color
                retryEmailTextFieldStatus.text = "일치"
                retryEmailBorder.isHidden = true
            } else {
                retryEmailTextFieldStatus.textColor = UIColor.status_no_Color
                retryEmailTextFieldStatus.text = "블일치"
                retryEmailTextFieldStatus.isHidden = false
                retryEmailBorder.isHidden = false
            }
        } else if sender.tag == 2 {
            if (passwordTextField.text?.isPasswordValid())! {
                passwordTextFieldStatus.isHidden = false
                passwordTextFieldStatus.textColor = UIColor.status_ok_Color
                passwordTextFieldStatus.text = "안전"
                
                passwordBorder.isHidden = true
            } else {
                passwordTextFieldStatus.isHidden = false
                passwordTextFieldStatus.textColor = UIColor.status_no_Color
                passwordTextFieldStatus.text = "불가"
                passwordBorder.isHidden = false
            }
        } else if sender.tag == 3 {
            if (retryPasswordTextField.text?.isPasswordValid())! && retryPasswordTextField.text == passwordTextField.text {
                retryPasswordTextFieldStatus.isHidden = false
                retryPasswordTextFieldStatus.textColor = UIColor.status_ok_Color
                retryPasswordTextFieldStatus.text = "일치"
                retryPasswordBorder.isHidden = true
            } else {
                retryPasswordTextFieldStatus.isHidden = false
                retryPasswordTextFieldStatus.textColor = UIColor.status_no_Color
                retryPasswordTextFieldStatus.text = "불일치"
                retryPasswordBorder.isHidden = false
            }
        }
        
        if retryPasswordTextFieldStatus.text == "일치" && passwordTextFieldStatus.text == "안전" && retryEmailTextFieldStatus.text == "일치" {
            let image = UIImage(named: "btn_next_On")
            self.nextButton.isEnabled = true
            self.nextButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "btn_next")
            self.nextButton.isEnabled = false
            self.nextButton.setImage(image, for: .normal)
        }
    }
        
    
    // textField 에디팅 될 때
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)! {
            deleteButtons[textField.tag].isHidden = false
        }
        return true
    }
    
    // 입력되어있는 비밀번호를 수정할 때
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 {
            retryPasswordTextFieldStatus.isHidden = true
            retryPasswordTextField.text = ""
        }
        return true
    }
    
    // textField 리자인 될 때
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        deleteButtons[textField.tag].isHidden = true
        return true
    }
}
