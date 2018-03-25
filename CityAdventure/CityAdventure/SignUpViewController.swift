//
//  SignUpViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 25..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var firstTextView: UITextView! {
        didSet {
            let attributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 12.0),
                                     NSAttributedStringKey.foregroundColor : UIColor.textView_gray_Color
            ]
            
            let attString = NSMutableAttributedString(string: firstTextView.text, attributes: attributedString)
            firstTextView.attributedText = attString
        }
    }
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "회원 가입"
        initNavigation()
        layoutCheck()
        // edge gesture set
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func initNavigation() {
       
         //navigation bar background, tintcolor
        self.navigationController?.navigationBar.barTintColor = UIColor.top_Brown_Color
        self.navigationController?.navigationBar.tintColor = .white

       // NavigationBar Title Style Set Font,Color
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font : UIFont(name: "GodoM", size: 16.0),
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
    }
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_X {
            topConstraint.constant = 100
        } else {
            topConstraint.constant = 80
        }
        
//        self.view.layoutIfNeeded()
    }
    
    @IBAction func tappedBackbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // tapped leftBarButton
    @objc func popView() {
        print("PopView")
        self.navigationController?.popViewController(animated: true)
    }
}
