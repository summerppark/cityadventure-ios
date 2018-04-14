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
        
        // 캐릭터 이미지
        if let avatar = info.ui_avatarNo {
            charImage.image = super.charImages[avatar-1]
        }
        
        // 나이를 계산.
        if let birth = info.date_birth {
            userAge.text = TimeFormatter().getCurrentAge(date_birth: birth)
            
            print(birth)
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
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.leftView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        print("ASD")
        self.leftView.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, animations: {
             self.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (finished) in
            
            self.view.removeFromSuperview()
        }
    }
}
