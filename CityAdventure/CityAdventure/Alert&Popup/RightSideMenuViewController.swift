//
//  RightSideMenuViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class RightSideMenuViewController: BaseViewController {
 
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var bgmSoundButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var effectSoundButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var provinceCity: UILabel!
    @IBOutlet weak var bgmButtn: UIButton!
    @IBOutlet weak var effectButton: UIButton!
    
    var audioIsPlay: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        addGesture()
        dataSetting()
    }
    
    
    
    // 사이드메뉴 데이터 셋팅.
    func dataSetting() {
        guard let info = DataManager.shared.userInfo?.userInfo else {
            return
        }
        
        if let name = info.s_name {
            userName.text = name
        }
        
        // 캐릭터 이미지
        if let avatar = info.ui_avatarNo {
            charImage.image = super.charImages[avatar-1]
        }
        
        // 나이를 계산.
        if let birth = info.date_birth {
            userAge.text = TimeFormatter().getCurrentAge(date_birth: birth)
        }
        
        // 사는 지역 보여주기.
        if let cityNumber = info.ui_livingCity {
        let temp = DataManager.shared.citynumbers[cityNumber-1]
            provinceCity.text = "\(temp.cityName) \(temp.areaName)"
        }
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCloseButton))
        leftView.addGestureRecognizer(tapGesture)
    }
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
        }
        
        if Constants.DeviceType.IS_IPHONE_6P {
        }
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let bgmData = UserDefaults.standard.object(forKey: "BGM") as? String {
            if bgmData == "TRUE" {
                bgmButtn.setImage(#imageLiteral(resourceName: "back_music_on"), for: .normal)
                audioIsPlay = false
            } else {
                audioIsPlay = true
                bgmButtn.setImage(#imageLiteral(resourceName: "back_music_off"), for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.leftView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    @IBAction func bgmControlButton(_ sender: UIButton) {
        
        if audioIsPlay {
            sender.setImage(#imageLiteral(resourceName: "back_music_on"), for: .normal)
            UserDefaults.standard.set("TRUE", forKey: "BGM")
            BGMPlayerManager.shared.bgmStart()
        } else {
             sender.setImage(#imageLiteral(resourceName: "back_music_off"), for: .normal)
            UserDefaults.standard.set("FALSE", forKey: "BGM")
            BGMPlayerManager.shared.bgmStop()
        }
        audioIsPlay = !audioIsPlay
    }
    
    @IBAction func shoppingMall(_ sender: UIButton) {
        if let url = URL(string: APIUrls.shoppingMallUrl()) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        hideView(type: 0)
    }
    
    
    @IBAction func goSetting(_ sender: UIButton) {
        if let setting = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController {
            setting.modalPresentationStyle = .overFullScreen
            setting.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            setting.delegate = self
            self.present(setting, animated: false, completion: nil)
        }
    }
    
    @IBAction func goTermsOfUse(_ sender: UIButton) {
        hideView(type: 2)
    }
    
    @IBAction func goClientCenter(_ sender: UIButton) {
        hideView(type: 3)
    }
    
    @IBAction func goAdventureExercise(_ sender: UIButton) {
        hideView(type: 5)
    }
    
    @IBAction func goMyCollectionCity(_ sender: UIButton) {
        hideView(type: 6)
    }
    
    @IBAction func goToQRCodeGame(_ sender: UIButton) {
        hideView(type: 7)
    }
    
    func hideView(type: Int) {
        self.leftView.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (finished) in
            self.view.removeFromSuperview()
            // Reset 일때
            if type == 1 {
                if let reset = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController {
                    self.navigationController?.pushViewController(reset, animated: true)
                }
            } else if type == 2 {
                if let termsOfUse = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfUseViewController") as? TermsOfUseViewController {
                    self.navigationController?.pushViewController(termsOfUse, animated: true)
                }
            } else if type == 3 {
                if let clientCenter = self.storyboard?.instantiateViewController(withIdentifier: "ClientCenterViewController") as? ClientCenterViewController {
                    self.navigationController?.pushViewController(clientCenter, animated: true)
                }
            } else if type == 4 {
                if let leave = self.storyboard?.instantiateViewController(withIdentifier: "LeaveViewController") as? LeaveViewController {
                    self.navigationController?.pushViewController(leave, animated: true)
                }
            } else if type == 5 {
                // 준비 운동
                if let adventureExercise = self.storyboard?.instantiateViewController(withIdentifier: "AdventureExerciseViewController") as? AdventureExerciseViewController{
                    self.navigationController?.pushViewController(adventureExercise, animated: true)
                }
            } else if type == 6 {
                
                // 내 컬렉션
                if let collect = self.storyboard?.instantiateViewController(withIdentifier: "MyCollectCityViewController") as? MyCollectCityViewController {
                    
                    if let vc = self.navigationController?.viewControllers.last as? MyCollectCityViewController {
                        print("이미",vc)
                    } else {
                        self.navigationController?.pushViewController(collect, animated: true)
                    }
                }
            } else if type == 7 {
                if let adventureQRCode = self.storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeViewController") as? AdventureQRCodeViewController {
                    
                    if let vc = self.navigationController?.viewControllers.last as? AdventureQRCodeViewController {
                        print("이미 QRCode")
                    } else {
                        self.navigationController?.pushViewController(adventureQRCode, animated: true)
                    }
                }
            } 
        }
    }
}


extension RightSideMenuViewController: SettingViewProtocol {
    func leave() {
        hideView(type: 4)
    }
    
    func resetPassword() {
        hideView(type: 1)
    }
    
    
    
}
