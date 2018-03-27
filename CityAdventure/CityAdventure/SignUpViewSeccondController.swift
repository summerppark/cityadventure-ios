//
//  SignUpViewSeccondController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class SignUpViewSeccondController: UIViewController {

    //헤더뷰 높이
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    //배경 뷰 높이
    @IBOutlet weak var login_bg_height: NSLayoutConstraint!
    
    
    @IBOutlet weak var loginLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var profileLabelHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
        }
        
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            login_bg_height.constant = 420
            loginLabelHeight.constant = 12
            profileLabelHeight.constant = 12
        }
    }
    
    
}
