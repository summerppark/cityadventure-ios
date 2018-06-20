//
//  LoginViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 23..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Toaster


class LoginViewController: BaseViewController {
    
    // Email
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    
    // Password
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
   
    var presenter: LoginViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //엣지 팝 제스쳐 끄기
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        
        initView()
        presenter = LoginViewPresenter(presenter: self)
        toastViewSetting()
        
    }
    
    func toastViewSetting() {
        
        ToastView.appearance().font = UIFont(name: "GodoM", size: 18.0)
        ToastView.appearance().frame = CGRect(x: 0, y: 0, width: 200, height: 150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // view set
    func initView() {
        // keyboard hide when touches
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardHide))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // selector tap gesture and keyboard hide
    @objc func keyboardHide() {
        self.view.endEditing(true)
    }

    @IBAction func tryEmailLogin(_ sender: UIButton) {
        guard emailTextField.text != "" || passwordTextField.text != "" else {
            print("아무 입력값도 없을 땐 통신할 필요도 없다.")
            return
        }
        // 키보드 내려준다.
        keyboardHide()
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            self.presenter.tryEmailLogin(email: email, password: password)
        }
    }
    
    //MARK:- FindPassword
    // 비밀번호 찾기 화면으로 이동
    @IBAction func findPassword(_ sender: Any) {
        if let findPwVC = storyboard?.instantiateViewController(withIdentifier: "FindPasswordViewController") as? FindPasswordViewController {
            self.navigationController?.pushViewController(findPwVC, animated: true)
        }
    }
    
    
    @IBAction func goToMain(_ sender: Any) {
        if let next = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    @IBAction func autoLogin(_ sender: UIButton) {
        
        guard let session = KOSession.shared() else { return }
        if session.isOpen() {
            session.close()
        }
        
        session.presentingViewController = self
        session.open { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else if session.isOpen() {
                KOSessionTask.userMeTask(completion: { (error, me) in
                    if let error = error as NSError? {
                        print(error, "Error")
                    } else if let me = me as KOUserMe? {
                        print("login",me)
                        dump(me)
                    } else {
                        print("아이디없다")
                    }
                })


            } else {
                print("failed")
            }
        }
        
    }
    
    
    
}

//MARK:- @IBAction
extension LoginViewController {
    @IBAction func tappedSignUp(sender: UIButton) {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    //MARK:- UnWind
    @IBAction func unWindLoginVC(_ segue: UIStoryboardSegue) {
        // 회원가입 완료 팝업 창에서 닫기 눌렀을 때 이쪽으로 소환
    }
}


extension LoginViewController: UITextFieldDelegate {
    // 키보드 Done 누를 시 화면 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension LoginViewController: LoginViewPresenterProtocol {
    func tryLoginHandler(nick: String) {
        stopLoading()
        // email, password 를 통해서 API 를 날려 토큰을 받아 온 후 바로 Token 을 가지고 유저 정보, 유저 계정정보 2군두에 통신을 시도한 후 핸들러로 이곳에 도착하여 메인뷰로 넘어간다.
        // Toast 를 위한 구문
        failEmailLogin(msg: "\(nick)대원님 환영합니다.")
        
        // Main 화면으로 보내기
        let main = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = main
    }

    func startLoading() {
        print("login시도중")
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    func failEmailLogin(msg: String?) {
        print("실패를 알려준다 토스트 온")
        Toast(text: msg).show()
    }
    
}
