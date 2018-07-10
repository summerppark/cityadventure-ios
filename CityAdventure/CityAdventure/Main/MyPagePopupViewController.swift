//
//  MyPagePopupViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class MyPagePopupViewController: BaseViewController {
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 1.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userCharView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var expMaxLabel: UILabel!
    @IBOutlet weak var expCurrentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myCardsCount: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    
    
    @IBOutlet weak var bornCityLabel: UILabel!
    @IBOutlet weak var bornCityArea: UILabel!
    
    @IBOutlet weak var livingCityLabel: UILabel!
    @IBOutlet weak var livingCityArea: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSetting()
        
    }
    
    
    func dataSetting() {
        guard let currentExp = DataManager.shared.getUserInfo()?.userInfo?.ui_exp else {
            return
        }
        
        
        let level = super.getLevel(exp: currentExp)
        let curExp = super.getAbsExp(exp: currentExp)
        let maxExp = super.getNextNeedExpByLevel(level: level)
        
        // 현재 레벨을 표현해준다.
        currentLevelLabel.text = "\(level)"
        expCurrentLabel.text = "\(curExp)"
        expMaxLabel.text = "\(maxExp)"
        
        print("level = ", level)
        print("currentExp = ", super.getAbsExp(exp: currentExp))
        print("maxExp = ", super.getNextNeedExpByLevel(level: level))
        
        if let coin = DataManager.shared.getUserInfo()?.userInfo?.ui_credit {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            myCoin.text = nf.string(from: NSNumber(integerLiteral: coin))
        }
        
        if let count = DataManager.shared.getUserCardInfo()?.dataLength {
            var str = ""
            if count < 10 {
                str = "00\(count)/162"
            } else if count < 100 {
                str = "0\(count)/162"
            } else {
                str = "\(count)/162"
            }
            
            myCardsCount.text = str
        }
        
        if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
            userNameLabel.text = name
        }
        
        
        if let index = DataManager.shared.getUserInfo()?.userInfo?.ui_avatarNo {
            print(index)
            userCharView.image = super.charImages[index-1]
        }
        
        // 프로그레스 뷰 상태를 셋팅
        progressView.progress = (Float(curExp)/Float(maxExp))
        
        
        
        
        
        if let userCharInfo = DataManager.shared.getUserInfo()?.userInfo {
            
            self.birthLabel.text = super.convertDateFormatter(inputDate: userCharInfo.date_birth)
            self.genderLabel.text = userCharInfo.c_gender == "m" ? "남자": "여자"
            if let born = userCharInfo.ui_homeProvince {
                self.bornCityArea.text = super.bornArea[born]
            }
            
            if let living = userCharInfo.ui_livingProvince {
                self.livingCityArea.text = super.bornArea[living]
            }
            
         
            if let bornIndex = userCharInfo.ui_homeCity {
                self.bornCityLabel.text = DataManager.shared.citynumbers[bornIndex].cityName
            }
            
            if let livingIndex = userCharInfo.ui_livingCity {
                self.livingCityLabel.text = DataManager.shared.citynumbers[livingIndex].cityName
            }
        }
    }
    
    @IBAction func close(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
