//
//  SignUpViewFinalController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 2..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class SignUpViewFinalController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = UserDefaults.standard.object(forKey: "signup_email"),
            let password = UserDefaults.standard.object(forKey: "signup_password"),
            let name = UserDefaults.standard.object(forKey: "signup_name"),
            let gender = UserDefaults.standard.object(forKey: "signup_gender"),
            let birthday = UserDefaults.standard.object(forKey: "signup_birthday"),
            let homeProvince = UserDefaults.standard.object(forKey: "signup_homeProvince"),
            let homeNumber = UserDefaults.standard.object(forKey: "signup_homeNumber"),
            let livingProvince = UserDefaults.standard.object(forKey: "signup_livingProvince"),
            let livingNumber = UserDefaults.standard.object(forKey: "signup_livingNumber"),
            let char = UserDefaults.standard.object(forKey: "signup_char"),
            let home = UserDefaults.standard.object(forKey: "signup_borncity"),
            let living = UserDefaults.standard.object(forKey: "signup_livecity") {
            
            
            self.name.text = name as? String ?? ""
            self.gender.text = (gender as! String) == "m" ? "남자" : "여자"
            self.birthDay.text = (birthday as? String) ?? ""
            self.homeProvince.text = home as? String ?? ""
            self.livingProvince.text = living as? String ?? ""
            
            
            print("Email => " ,email)
            print("password => " ,password)
            print("name => " ,name)
            print("gender => " ,gender)
            print("birthday => " ,birthday)
            print("homeProvince => " ,homeProvince)
            print("homeNumber => " ,homeNumber)
            print("livingProvince => " ,livingProvince)
            print("livingNumber => " ,livingNumber)
            print("char => " ,char)
            
        }
    }
    
    
    @IBAction func modifyInfo(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func signUpSuccess(_ sender: Any) {
        if let success = storyboard?.instantiateViewController(withIdentifier: "SignUpSuccessViewController") as? SignUpSuccessViewController {
            success.name = self.name.text
            success.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            success.modalPresentationStyle = .overFullScreen
            
            self.present(success, animated: false, completion: nil)
        }
    }
    
    
}
