//
//  SignUpViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 25..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let attributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 12.0),
                             NSAttributedStringKey.foregroundColor : UIColor.textView_gray_Color
    ]
    
    
    
    @IBOutlet weak var headerToolbar: UIView!
    @IBOutlet weak var headerToolbarHeight: NSLayoutConstraint!
    
    
    @IBOutlet var textViewHeights: [NSLayoutConstraint]!
    
    
    
    
    
    
    
    @IBOutlet weak var firstTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: firstTextView.text, attributes: attributedString)
            firstTextView.attributedText = attString
            self.firstTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    @IBOutlet weak var secondTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: secondTextView.text, attributes: attributedString)
            secondTextView.attributedText = attString
            self.secondTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    @IBOutlet weak var thirdTextView: UITextView! {
        didSet {
            let attString = NSMutableAttributedString(string: thirdTextView.text, attributes: attributedString)
            thirdTextView.attributedText = attString
            self.thirdTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    
    @IBOutlet weak var firstCheckIcon: UIButton! {
        didSet {
            firstCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    @IBOutlet weak var secondCheckIcon: UIButton! {
        didSet {
            secondCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    @IBOutlet weak var thirdCheckIcon: UIButton! {
        didSet {
            thirdCheckIcon.addTarget(self, action: #selector(tappedCheck), for: .touchUpInside)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "회원 가입"
        initNavigation()
        layoutCheck()
        // edge gesture set
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        
        firstCheckIcon.setImage(UIImage(named:"auto_login_ok"), for: .selected)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    // iPhone X 상단 바 높이 조정
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerToolbarHeight.constant = 88
        }
        
        if Constants.DeviceType.IS_IPHONE_X || Constants.DeviceType.IS_IPHONE_6P {
            textViewHeights.forEach({ height in
                height.constant = 160
            })
        }
        
    }
    
    @IBAction func tappedBackbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // tapped leftBarButton
    @objc func tappedCheck(sender: UIButton) {
        if sender.currentImage == UIImage(named: "noncheck") {
            sender.setImage(UIImage(named:"auto_login_ok"), for: .normal)
        } else {
            sender.setImage(UIImage(named:"noncheck"), for: .normal)
        }
    }
}
