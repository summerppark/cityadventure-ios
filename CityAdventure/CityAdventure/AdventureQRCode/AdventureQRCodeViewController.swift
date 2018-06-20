//
//  AdventureQRCodeViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeViewController: BaseViewController {
    
    // 파랑색 네모 높이
    @IBOutlet weak var squareHeight: NSLayoutConstraint!
    @IBOutlet weak var textTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var userCharView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var expMaxLabel: UILabel!
    @IBOutlet weak var expCurrentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myCardsCount: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 1.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var progressViewLeading: NSLayoutConstraint!
    @IBOutlet weak var userNameLabelTrailing: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var mainAvartarView: UIImageView!
    @IBOutlet weak var mainNickname: UILabel!
    @IBOutlet weak var mainCityCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        dataSetting()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            
            // iPhone X 일 때 레이아웃
        }
        
        if Constants.DeviceType.IS_IPHONE_6P {
            progressViewLeading.constant = 12
            userNameLabelTrailing.constant = 24
        }
        
        if Constants.DeviceType.IS_IPHONE_X || Constants.DeviceType.IS_IPHONE_6P {
            squareHeight.constant = 340
            textTopConstraint.constant = 78
            
        }
    
    }
    
    @IBAction func unWindQRCodeVC(_ segue: UIStoryboardSegue) {
        // 회원가입 완료 팝업 창에서 닫기 눌렀을 때 이쪽으로 소환
        print("unwind", segue.identifier)
        
        
        // 퍼즐을 획득하고 화면 전환. 바로 수집되있는 부분으로 이동.
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if let id = segue.identifier, id == "goCollectVC" {
                if let collect = self.storyboard?.instantiateViewController(withIdentifier: "MyCollectCityViewController") as? MyCollectCityViewController {
                    self.navigationController?.pushViewController(collect, animated: true)
                }
            }
        }
       
        
    }
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func presentRightSideMenu(_ sender: UIButton) {
        super.showMenu {
            super.backgroundBlackAlpha(view: self.view)
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func goToQRCodeReader(_ sender: Any) {
        
        if let qrCodeReaderView = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeReaderViewController") as? AdventureQRCodeReaderViewController {
            self.navigationController?.pushViewController(qrCodeReaderView, animated: true)
        }
    }
    
    @IBAction func goToMyCollectionView(_ sender: Any) {
        
        if let collect = storyboard?.instantiateViewController(withIdentifier: "MyCollectCityViewController") as? MyCollectCityViewController {
            self.navigationController?.pushViewController(collect, animated: true)
        }
    }
    
    
    // 상단 뷰 데이타 셋팅
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
            myCoin.text = "\(coin)"
        }
        
        if let count = DataManager.shared.getUserCardInfo()?.dataLength {
            var str = ""
            if count < 10 {
                str = "00\(count)"
            } else if count < 100 {
                str = "0\(count)"
            } else {
                str = "\(count)"
            }
            
            myCardsCount.text = str
            mainCityCount.text = str
        }
        
        if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
            userNameLabel.text = name
            mainNickname.text = name
        }
        
        
        if let index = DataManager.shared.getUserInfo()?.userInfo?.ui_avatarNo {
            print(index)
            userCharView.image = super.charImages[index-1]
            mainAvartarView.image = super.mainCharImages[index-1]
        }
        
        // 프로그레스 뷰 상태를 셋팅
        progressView.progress = (Float(curExp)/Float(maxExp))
    }
    
}
