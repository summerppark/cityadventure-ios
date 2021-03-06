//
//  MyPagePopupViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Toaster
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
    
    @IBOutlet weak var coinView: UIView! {
        didSet {
            coinView.layer.cornerRadius = 8.0
            coinView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var expView: UIView! {
        didSet {
            expView.layer.cornerRadius = 8.0
            expView.clipsToBounds = true
        }
    }
    
    
    
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
        print("DataManager.shared.userInfo?.userInfo?.ui_avatarNo",DataManager.shared.userInfo?.userInfo?.ui_avatarNo)
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
                self.bornCityLabel.text = DataManager.shared.citynumbers[bornIndex-1].cityName
            }
            
            if let livingIndex = userCharInfo.ui_livingCity {
                self.livingCityLabel.text = DataManager.shared.citynumbers[livingIndex-1].cityName
            }
        }
    }
    
    @IBAction func myNote(_ sender: UIButton) {
        if let note = self.storyboard?.instantiateViewController(withIdentifier: "MyNoteViewController") as? MyNoteViewController {
            self.present(note, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedCollectCity(_ sender: Any) {
        if let collect = self.storyboard?.instantiateViewController(withIdentifier: "MyCollectCityViewController") as? MyCollectCityViewController {
            self.navigationController?.pushViewController(collect, animated: true)
        }
    }
    
    
    @IBAction func close(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editMyInfo(_ sender: UIButton) {
        if let edit = self.storyboard?.instantiateViewController(withIdentifier: "EditMyAccountInfoViewController") as? EditMyAccountInfoViewController {
            
            edit.editedName = self.userNameLabel.text ?? "BUBU"
            edit.editedBirth = self.birthLabel.text ?? "BUBU"
            edit.editedBornCity = "\(self.bornCityArea.text ?? "") \(self.bornCityLabel.text ?? "")"
            edit.editedCurrentCity = "\(self.livingCityArea.text ?? "") \(self.livingCityLabel.text ?? "BUBU")"
            edit.editedGender = self.genderLabel.text ?? "" == "남자" ? true : false
            self.navigationController?.pushViewController(edit, animated: true)
        }
    }
    
    
    @IBAction func diaryRank(_ sender: Any) {
        Toast.init(text: "서비스 준비중 입니다.", delay: 0.0, duration: 0.15).show()
    }
    
    @IBAction func changeChar(_ sender: UIButton) {
        if let charChange = self.storyboard?.instantiateViewController(withIdentifier: "AvatarManageMentViewController") as? AvatarManageMentViewController {
            self.navigationController?.pushViewController(charChange, animated: true)
        }
    }
    
    
}
