//
//  ClientCenterViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import Alamofire
import Toaster

class ClientCenterViewController: BaseViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
   
    @IBOutlet weak var backGroundView2: UIView! {
        didSet {
            backGroundView2.layer.cornerRadius = 8.0
            backGroundView2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet {
            backGroundView.layer.cornerRadius = 8.0
            backGroundView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userEmail: UILabel! {
        didSet {
            if let email = DataManager.shared.userAccountInfo?.userAccountInfo?.s_email {
                userEmail.text = email
            }
        }
    }
    
    
    @IBOutlet weak var backGroundView3: UIView! {
        didSet {
            backGroundView3.layer.cornerRadius = 8.0
            backGroundView3.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var textView: UITextView! {
        didSet {

            textView.placeholder = "문의내용을 상세히 보내주시면 더욱 빨리 답변이 가능합니다!"
            textView.delegate = self
        }
    }
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    @IBAction func send(_ sender: Any) {
        if let token = UserDefaults.standard.object(forKey: "token") as? String,
            let email = DataManager.shared.userAccountInfo?.userAccountInfo?.s_email, let member = DataManager.shared.userAccountInfo?.userAccountInfo?.no, let content = textView.text, let subject = titleTextField.text, content != "", subject != "" {
            
            let url = APIUrls.leaveBubuApp(member: member, token: token, email: email, subject: subject, content: content, type: 1).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            super.showLoading(view: self.view)
            Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default).responseObject(completionHandler: { (response: DataResponse<NewBaseResponse>) in
                switch response.result {
                case .success:
                    if let popup = self.storyboard?.instantiateViewController(withIdentifier: "LeavePopupViewController") as? LeavePopupViewController {
                        popup.titleString = "문의 접수 완료"
                        popup.contentString1 = "회원님의 문의가 접수되었습니다."
                        popup.contentString2 = "이메일로 답변이 발송될 예정입니다."
                        popup.modalPresentationStyle = .overCurrentContext
                        popup.delegate = self
                        self.present(popup, animated: false) {
                            super.hideLoading()
                        }
                    }
                    
                    break
                case .failure:
                    Toast.init(text: "에러가 발생했습니다. 다시 시도해 주세요.").show()
                    super.hideLoading()
                    break
                }
            })
        } else {
            Toast.init(text: "입력한 내용을 확인해주세요.").show()
            super.hideLoading()
        }
            
    }
    
    
}



extension ClientCenterViewController: UITextViewDelegate {
}

extension ClientCenterViewController: LeavePopupProtocol {
    func dismissAfter() {
        textView.text = ""
        titleTextField.text = ""
//        self.navigationController?.popViewController(animated: true)
    }
}
