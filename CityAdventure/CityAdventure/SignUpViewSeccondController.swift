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
    
    // 로그인 정보 레이블 컨스트레인트
    @IBOutlet weak var loginLabelHeight: NSLayoutConstraint!
    
    // 프로필 등록 컨스트레인트
    @IBOutlet weak var profileLabelHeight: NSLayoutConstraint!

    // 디바이스별로 공간을 넓히기 위한 컨스트레인트
    @IBOutlet weak var topconst1: NSLayoutConstraint!
    @IBOutlet weak var topconst3: NSLayoutConstraint!
    
    // 첫번째 입력 부분 - 이메일 입력
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailDeleteButton: UIButton!
    @IBOutlet weak var duplicatedCheckButton: UIButton!
    
    // 두번째 입력 부분 - 이메일 재입력
    @IBOutlet weak var retryEmailTextField: UITextField!
    @IBOutlet weak var retryEmailTextFieldStatus: UILabel!
    @IBOutlet weak var retryEmailBorder: UIImageView!
    
    @IBOutlet weak var retryEmailDeleteButton: UIButton!
    
    // 3번째 입력 부분 - 비밀번호 입력
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordDeleteButton: UIButton!
    @IBOutlet weak var passwordTextFieldStatus: UILabel!
    @IBOutlet weak var passwordBorder: UIImageView!
    
    // 4번재 입력 부분 - 비밀번호 재입력
    @IBOutlet weak var retryPasswordTextField: UITextField!
    @IBOutlet weak var retryPasswordTextFieldStatus: UILabel!
    @IBOutlet weak var retryPasswordDeleteButton: UIButton!
    @IBOutlet weak var retryPasswordBorder: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
            
            // iPhone X 일 때 레이아웃
           
        }
        
        // iPhoneX ,plus 일 때 레이아웃
        // 배경 높이 올려주고 레이블 컨스트레인트조정
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            login_bg_height.constant = 380
            loginLabelHeight.constant = 8
            profileLabelHeight.constant = 8
            
            topconst1.constant = 18
            topconst3.constant = 18
            
            
        }
    }
    
    
}
