//
//  LogoutViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 16..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit
import Toaster

class LogoutViewController: UIViewController {
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertView.snp.trailing).offset(-4)
            make.centerY.equalTo(alertView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    
    @IBAction func agreeLogout(sender: UIButton) {
        self.dismiss(animated: false) {
            Toast(text: "로그아웃 되었습니다.").show()
            
            UserDefaults.standard.set(nil, forKey: "auto_email")
            UserDefaults.standard.set(nil, forKey: "auto_password")
            
            let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: login)
            let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navigationController
        }
    }
    
    @IBAction func cancleLogout(sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
