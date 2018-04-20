//
//  LeaveViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 19..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class LeaveViewController: BaseViewController {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.layer.cornerRadius = 8.0
            borderView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.placeholder = "메일을 통한 접수이후 전화응대를 통해 탈퇴가 진행됩니다. \n탈퇴 사유를 상세히 남겨주시면 더욱 원할한 상담이 가능합니다."
        }
    }
    
    @IBOutlet weak var borderView2: UIView! {
        didSet {
            borderView2.layer.cornerRadius = 8.0
            borderView2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutCheck()
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
