//
//  FindPasswordSecondViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class FindPasswordSecondViewController: BaseViewController {

    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var NoGetNumberButton: UIButton! {
        didSet {
            let attributeString = NSMutableAttributedString(string: NoGetNumberButton.currentTitle!,
                                                            attributes: yourAttributes)
            NoGetNumberButton.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
    let yourAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.init(name: "GodoM", size: 13.0),
        NSAttributedStringKey.foregroundColor : UIColor.red,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]

    @IBOutlet weak var numberTextField: UITextField!
    
    var email: String?
    var presenter: FindPasswordSecondPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FindPasswordSecondPresenter(presenter: self)
        
        layoutCheck()
        addGesture()
    }
    
    func addGesture() {
        //배경 눌럿을 때 키보드 하이드
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardHide))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    @objc func keyboardHide() {
        self.view.endEditing(true)
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func authCheck(_ sender: UIButton) {
        //인증번호를 작성한 후 요청
        if let email = email,
            let number = numberTextField.text {
            self.presenter.tryAccessNumberCheck(email: email, number: number)
        }
    }
    
    
    // 인증메일 재발송
    @IBAction func retryAuth(_ sender: Any) {
        if let retryAuthAlertView = storyboard?.instantiateViewController(withIdentifier: "RetryAuthAlertViewController") as? RetryAuthAlertViewController {
            retryAuthAlertView.currentEmail = self.email
            retryAuthAlertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            retryAuthAlertView.modalPresentationStyle = .overFullScreen
            
            self.present(retryAuthAlertView, animated: false, completion: nil)
        }
    }
}



extension FindPasswordSecondViewController: FindPasswordSecondPresenterProtocol {
    func presentAlert(isSuccess: Bool) {
        print("인증번호 확인결과를 띄우는 알럿,", isSuccess)
        let title: String = isSuccess ? "비밀번호 변경 성공" : "비밀번호 변경 실패"
        let desc: String = isSuccess ? "임시비밀번호로 변경되었습니다." : "유효한 인증번호가 아닙니다."
        
        if let authResultAlertView = storyboard?.instantiateViewController(withIdentifier: "AlertGreenViewController") as? AlertGreenViewController {
            authResultAlertView.titleText = title
            authResultAlertView.descText = desc
            authResultAlertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            authResultAlertView.modalPresentationStyle = .overFullScreen
            self.present(authResultAlertView, animated: false, completion: nil)
        }
        
        
        
    }
    
    func startLoading() {
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    
}
