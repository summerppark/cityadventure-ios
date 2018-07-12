//
//  FindPasswordViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class FindPasswordViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewTopCons: NSLayoutConstraint!
    @IBOutlet weak var buttonTopCons: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTopConst: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    var presenter: FindPasswordPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        presenter = FindPasswordPresenter(presenter: self)
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
        
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            label.font = UIFont(name: "GodoM", size: 22)
            viewTopCons.constant = 36
            mainViewHeight.constant = 360
            labelTopConst.constant = 60
            buttonTopCons.constant = 42
        }
    }
    
    @IBAction func emailCheckSend(_ sender: Any) {
        // 버튼 눌렀을 때
        self.view.endEditing(true)
        self.presenter.findPassword(email: emailTextField.text ?? "잘못 입력하였습니다." )
    }
    
    
    @objc func keyboardHide() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}


extension FindPasswordViewController: FindPasswordPresenterProtocl {
    func presentAlertView(text: String) {
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AlertviewController") as? AlertviewController {
            alert.alertString = text
            alert.delegate = self
            alert.modalPresentationStyle = .overFullScreen
            alert.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.present(alert, animated: false)
        }
    }
    
    func startLoading() {
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
}


extension FindPasswordViewController: AlertViewProtocol {
    func successEdit() {
        
    }
    
    func successCallback() {
        print("사용되지않는")
    }
    
    func successAuth() {
        // 넥스트 인증번호 입력 란으로 변경.
        if let authCheckVC = storyboard?.instantiateViewController(withIdentifier: "FindPasswordSecondViewController") as? FindPasswordSecondViewController {
            authCheckVC.email = self.emailTextField.text
            self.navigationController?.pushViewController(authCheckVC, animated: true)
        }
    }
}
