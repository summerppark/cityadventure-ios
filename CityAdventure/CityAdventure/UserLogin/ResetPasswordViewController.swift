//
//  ResetPasswordViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var passwordDeleteButton: UIButton!
    @IBOutlet weak var passwordStatusLabel: UILabel!
    @IBOutlet weak var passwordBorder: UIImageView!
    
    
    @IBOutlet weak var retryPasswordTextField: UITextField! {
        didSet {
            retryPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var retryPasswordDeleteButton: UIButton!
    @IBOutlet weak var retryPasswordStatusLabel: UILabel!
    @IBOutlet weak var retryPasswordBorder: UIImageView!
    
    
    // 삭제버튼
    var deleteButtons: [UIButton] = []
    
    // Presenter!!!
    var presenter: ResetPasswordPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        retryPasswordTextField.delegate = self
      
        presenter = ResetPasswordPresenter(presenter: self)
        
        deleteButtons = [passwordDeleteButton, retryPasswordDeleteButton]
        
        layoutCheck()
        addGesture()
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardHide))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardHide() {
        self.view.endEditing(true)
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    
    @IBAction func tappedDelete(_ sender: UIButton) {
        if sender.tag == 0 {
            passwordTextField.text = ""
        } else {
            retryPasswordTextField.text = ""
        }
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tappedOKButton(_ sender: UIButton) {
        if passwordStatusLabel.text == "안전" && retryPasswordStatusLabel.text == "일치" {
            if let token = UserDefaults.standard.object(forKey: "token") as? String, let pw = passwordTextField.text {
                print("----",token,pw)
                self.presenter.tryChangePassword(token: token, password: pw)
            }
        }
    }
}


extension ResetPasswordViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.tag == 0 {
            if (passwordTextField.text?.isPasswordValid())! {
                passwordStatusLabel.isHidden = false
                passwordStatusLabel.textColor = UIColor.status_ok_Color
                passwordStatusLabel.text = "안전"
                passwordBorder.isHidden = true
            } else {
                passwordStatusLabel.isHidden = false
                passwordStatusLabel.textColor = UIColor.status_no_Color
                passwordStatusLabel.text = "불가"
                passwordBorder.isHidden = false
            }
        } else if sender.tag == 1 {
            if (retryPasswordTextField.text?.isPasswordValid())! && retryPasswordTextField.text == passwordTextField.text {
                retryPasswordStatusLabel.isHidden = false
                retryPasswordStatusLabel.textColor = UIColor.status_ok_Color
                retryPasswordStatusLabel.text = "일치"
                retryPasswordBorder.isHidden = true
            } else {
                retryPasswordStatusLabel.isHidden = false
                retryPasswordStatusLabel.textColor = UIColor.status_no_Color
                retryPasswordStatusLabel.text = "불일치"
                retryPasswordBorder.isHidden = false
            }
        }
         if passwordStatusLabel.text == "안전" && retryPasswordStatusLabel.text == "일치" {
            okButton.isEnabled = true
            okButton.titleLabel?.textColor = UIColor.black
         } else {
            okButton.isEnabled = false
            okButton.titleLabel?.textColor = UIColor.lightGray
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)! {
            deleteButtons[textField.tag].isHidden = false
        }
        return true
    }
    
    
    // 다음텍스트필드로 바로 변경 마지막은 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    // textField 리자인 될 때
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        deleteButtons[textField.tag].isHidden = true
        return true
    }
}


extension ResetPasswordViewController: ResetPasswordPresenterProtocol {
    func changePasswordResult(message: String) {
         if let alert = storyboard?.instantiateViewController(withIdentifier: "AlertviewController") as? AlertviewController {
            alert.alertString = message
            alert.modalPresentationStyle = .overFullScreen
            alert.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            alert.delegate = self
            self.present(alert, animated: false, completion: nil)
        }
        
    }
    
    func startLoading() {
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    
   
}


extension ResetPasswordViewController: AlertViewProtocol {
    func successEdit() {
        
    }
    
    func successAuth() {
        print("ㅇㅣ쪽은 사용되지 않는 프로토콜")
    }
    
    // 비밀번호가 정상적으로 변경되었을 때 다시 로그인 하도록 화면을 전환시켜준다.
    func successCallback() {
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: login)
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
    }
    
}
