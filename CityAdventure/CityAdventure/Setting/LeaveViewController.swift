//
//  LeaveViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 19..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import Alamofire
import Toaster

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
    
    @IBOutlet weak var phoneNumber: UITextField!
    
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
    
    @IBAction func leaveBUBU(_ sender: UIButton) {
        //1415
        if let token = UserDefaults.standard.object(forKey: "token") as? String,
            let email = DataManager.shared.userAccountInfo?.userAccountInfo?.s_email, let member = DataManager.shared.userAccountInfo?.userAccountInfo?.no, let content = textView.text, let phoneNumber = phoneNumber.text, phoneNumber != "", content != "" {
            
            let leaveUrl = APIUrls.leaveBubuApp(member: member, token: token, email: email, subject: "탈퇴하기-\(phoneNumber)", content: content, type: 2).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            super.showLoading(view: self.view)
            Alamofire.request(leaveUrl, method: .post, parameters: nil, encoding: JSONEncoding.default).responseObject(completionHandler: { (response: DataResponse<NewBaseResponse>) in
                switch response.result {
                case .success:
                    if let popup = self.storyboard?.instantiateViewController(withIdentifier: "LeavePopupViewController") as? LeavePopupViewController {
                        
                        popup.modalPresentationStyle = .overCurrentContext
                        self.present(popup, animated: false, completion: {
                            super.hideLoading()
                        }
                        )
                    }
                    
                    break
                case .failure:
                    Toast.init(text: "에러가 발생했습니다. 다시 시도해 주세요.").show()
                    super.hideLoading()
                    break
                }
            })
        } else {
            Toast.init(text: "에러가 발생했습니다. 다시 시도해 주세요.").show()
        }
    }
}
