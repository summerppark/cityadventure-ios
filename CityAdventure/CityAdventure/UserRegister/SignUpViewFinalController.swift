//
//  SignUpViewFinalController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 2..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class SignUpViewFinalController: BaseViewController {
    
    //어떤캐릭터를 골랐는지.
    var charIndex: Int = 0
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthDay: UILabel!
    @IBOutlet weak var homeProvince: UILabel!
    @IBOutlet weak var livingProvince: UILabel!
    @IBOutlet weak var charImage: UIImageView! {
        didSet {
            charImage.image = thumbCharSelected[charIndex]
        }
    }
    
    let thumbCharSelected = [#imageLiteral(resourceName: "img_thumbChar_first_On"),#imageLiteral(resourceName: "img_thumbChar_second_On"),#imageLiteral(resourceName: "img_thumbChar_third_On"),#imageLiteral(resourceName: "img_thumbChar_fourth_On")]
    
    //MARK:- Presenter 선언
    var presenter: SignUpFinalPresenter!
    var parameters: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SignUpFinalPresenter(presenter: self)
        
        //USerdefault를 사용하여 저장한 데이터를 가져옴.
        if let email = UserDefaults.standard.object(forKey: "signup_email"),
            let password = UserDefaults.standard.object(forKey: "signup_password"),
            let name = UserDefaults.standard.object(forKey: "signup_name"),
            let gender = UserDefaults.standard.object(forKey: "signup_gender") ,
            let birthday = UserDefaults.standard.object(forKey: "signup_birthday"),
            let homeProvince = UserDefaults.standard.object(forKey: "signup_homeProvince"),
            let homeNumber = UserDefaults.standard.object(forKey: "signup_homeNumber"),
            let livingProvince = UserDefaults.standard.object(forKey: "signup_livingProvince"),
            let livingNumber = UserDefaults.standard.object(forKey: "signup_livingNumber"),
            let home = UserDefaults.standard.object(forKey: "signup_borncity"),
            let living = UserDefaults.standard.object(forKey: "signup_livecity") {
            
            
            self.name.text = name as? String ?? ""
            self.gender.text = (gender as! String) == "m" ? "남자" : "여자"
            self.birthDay.text = (birthday as? String) ?? ""
            self.homeProvince.text = home as? String ?? ""
            self.livingProvince.text = living as? String ?? ""
            
            print("FinalTest", SignUpViewSeccondController.signupEmail, SignUpViewSeccondController.signupPassword, SignUpViewSeccondController.signupName,SignUpViewSeccondController.signupGender,SignUpViewSeccondController.signupBirthday, SignUpViewSeccondController.signupHomeProvince,SignUpViewSeccondController.signupHomeNumber,SignUpViewSeccondController.signupLivingProvince,SignUpViewSeccondController.signupLivingNumber,SignUpViewSeccondController.signupBornCity,SignUpViewSeccondController.signupLiveCity,charIndex)
            
            
            
            // 서버로 보낼 파라미터
            parameters = [
                "userLoginType": "0",
                "email": email as! String,
                "password": password as! String,
                "kakaoId": "0",
                "name": name as! String,
                "gender": gender as! String,
                "homeProvince": String(describing: homeProvince),
                "homeCity": String(describing:homeNumber),
                "livingProvince": String(describing: livingProvince),
                "livingCity": String(describing:livingNumber),
                "birth": birthday as! String,
                "avatarNo": String(charIndex)
            ]
        }
    }
    
    // 수정하기 -> 뒤로감
    @IBAction func modifyInfo(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 가입완료버튼
    @IBAction func signUpSuccess(_ sender: Any) {
        self.presenter.connectPostSignUp(parameter: parameters)
    }
    
    // 가입 성공 되면 완료 됬다는 알럿창을 띄워준다
    func presentSuccessAlert() {
        if let success = storyboard?.instantiateViewController(withIdentifier: "SignUpSuccessViewController") as? SignUpSuccessViewController {
            success.name = self.name.text
            success.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            success.modalPresentationStyle = .overFullScreen
            
            self.present(success, animated: false, completion: nil)
        }
    }
}


extension SignUpViewFinalController: SignUpFinalPresenterProtocol {
    func signUpResult(text: String) {
        presentSuccessAlert()
    }
    
    func startLoading() {
        print("LOADING")
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        print("Hide")
        super.hideLoading()
    }
}
