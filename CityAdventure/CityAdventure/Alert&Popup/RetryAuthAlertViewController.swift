//
//  RetryAuthAlertViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit
import Toaster

class RetryAuthAlertViewController: BaseViewController {
    
    @IBOutlet weak var close: UIButton! {
        didSet {
            close.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var alertView: UIView! {
        didSet {
            self.alertView.layer.cornerRadius = 16.0
            self.alertView.clipsToBounds = true
        }
    }

    var currentEmail: String?
    
    var presenter: FindPasswordPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButtonLayout()
        presenter = FindPasswordPresenter(presenter: self)
        
    }
    
    
    func closeButtonLayout() {
        close.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertView.snp.trailing).offset(-4)
            make.centerY.equalTo(alertView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    @objc func closeAlert() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func authNumberResend(_ sender: UIButton) {
        if let email = currentEmail {
            print(email)
            self.presenter.findPassword(email: email)
        }
    }

}

extension RetryAuthAlertViewController: FindPasswordPresenterProtocl {
    func presentAlertView(text: String) {
        self.view.backgroundColor? = .clear
        self.dismiss(animated: true) {
            Toast(text: text).show()
        }
    }
    
    func startLoading() {
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    
}
