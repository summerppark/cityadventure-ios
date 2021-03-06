//
//  SignUpViewSeccondController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewSeccondController: BaseViewController {

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
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.addTarget(self, action: #selector(goToNext), for: .touchUpInside)
        }
    }
    
    // 텍스트필드 배열
    var textFields: [UITextField] = []
    var deleteButtons: [UIButton] = []
    var isValidEmail: Bool = false
    
    
    
    // Login Info static
    static var signupEmail: String = ""
    static var signupPassword: String = ""
    static var signupName: String = ""
    static var signupGender: String = ""
    static var signupBirthday: String = ""
    static var signupHomeProvince: String = ""
    static var signupHomeNumber: String = ""
    static var signupLivingProvince: String = ""
    static var signupLivingNumber: String = ""
    static var signupBornCity: String = ""
    static var signupLiveCity: String = ""
    
    
    
    //Presenter
    var presenter: SignUpViewSecondPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 텍스트필드 배열
        
        textFields = [emailTextField, retryEmailTextField, passwordTextField, retryPasswordTextField]
        
        // 삭제 버튼 배열
        deleteButtons = [emailDeleteButton, retryEmailDeleteButton, passwordDeleteButton, retryPasswordDeleteButton]
        
        textFields.forEach { (tf) in
            tf.delegate = self
        }
        
        presenter = SignUpViewSecondPresenter(presenter: self)
        
        addGesture()
        layoutCheck()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Email , Password 저장
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            SignUpViewSeccondController.signupEmail = email
            SignUpViewSeccondController.signupPassword = password
            
            UserDefaults.standard.set(email, forKey: "signup_email")
            UserDefaults.standard.set(password, forKey: "signup_password")
        }
    }
    
    func addGesture() {
        //배경 눌럿을 때 키보드 하이드
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //디바이스에따른 설정
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
    
    // 다음 화면으로 이동
    @objc func goToNext() {
        //다음 화면으로 이동할 시에 이메일과 비밀번호를 저장해둔다.
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "SignupViewThirdController") as? SignupViewThirdController {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    // 배경 눌렀을 때 키보드 내려감
    @objc func tappedBackgroundView() {
        statusCheck()
        self.view.endEditing(true)
    }
    
    // 삭제 버튼 눌렀을 때 입력 값 지움
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        textFields[sender.tag].text = ""
        self.duplicatedCheckButton.setImage(UIImage(named:"btn_duplicated_icon_before"), for: .normal)
    }
    
    @IBAction func tappedBackbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func emailDuplicateCheck(_ sender: Any) {
        
        guard let email = emailTextField.text , email != "" else {
            print("email값이 없으면 그냥 종료")
            return 
        }

        self.presenter.isValidEmailAddress(email: email)
    }
    
}


extension SignUpViewSeccondController: UITextFieldDelegate {
    
    // 입력값에 따른 상태 체크
    @objc func textFieldDidChange(sender: UITextField) {
        
        if let emailCheck = self.emailTextField.text, emailCheck == "" {
            self.duplicatedCheckButton.setImage(UIImage(named:"btn_duplicated_icon_before"), for: .normal)
        }
        
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
        statusCheck()
    }

    func statusCheck() {
        if retryPasswordTextFieldStatus.text == "일치" && passwordTextFieldStatus.text == "안전" && retryEmailTextFieldStatus.text == "일치" && isValidEmail && passwordTextField.text != "" && retryPasswordTextField.text != "" {
            let image = UIImage(named: "btn_next_On")
            self.nextButton.isEnabled = true
            self.nextButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "btn_next")
            // 임시로 열어둠
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
            statusCheck()
        }
        return true
    }
    
    // 다음텍스트필드로 바로 변경 마지막은 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            retryEmailTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            passwordTextField.becomeFirstResponder()
        } else if textField.tag == 2 {
            retryPasswordTextField.becomeFirstResponder()
        } else if textField.tag == 3 {
            self.view.endEditing(true)
        }
        
        // 입력상태가 모두 올바르면 다음으로 넘어감
        statusCheck()
        
        return true
    }
    
    // textField 리자인 될 때
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        deleteButtons[textField.tag].isHidden = true
        return true
    }
}


extension SignUpViewSeccondController: SignUpViewSecondPresenterProtocol {
    func presentAlertView(text: String) {
        // 통신 결과를 프리젠트시켜준다.
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AlertviewController") as? AlertviewController {
            alert.alertString = text
            alert.modalPresentationStyle = .overFullScreen
            alert.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.present(alert, animated: false) { [weak self] in
                if text.first == "이" || text.first == "잘" {
                    self?.emailTextField.text = ""
                    self?.duplicatedCheckButton.setImage(UIImage(named:"btn_duplicated_icon_before"), for: .normal)
                } else {
                    self?.isValidEmail = true
                    self?.duplicatedCheckButton.setImage(UIImage(named:"btn_duplicated_icon_after"), for: .normal)
                    self?.statusCheck()
                }
            }
        }
    }
    
    func startLoading() {
        super.showLoading(view: self.view)
        print("로딩시작")
    }
    
    func stopLoading() {
        super.hideLoading()
        print("로딩 머뭄")
    }
}
