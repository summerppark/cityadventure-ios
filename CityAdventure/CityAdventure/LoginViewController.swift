//
//  LoginViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 23..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //엣지 팝 제스쳐 끄기
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        
        initView()
        
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
}

//MARK:- @IBAction
extension LoginViewController {
    @IBAction func tappedSignUp(sender: UIButton) {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    @IBAction func unWindLoginVC(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
}


extension LoginViewController: UITextFieldDelegate {
    // 키보드 Done 누를 시 화면 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
