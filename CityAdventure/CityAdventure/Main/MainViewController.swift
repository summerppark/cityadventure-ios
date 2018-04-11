//
//  MainViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainBackgroundImage: UIImageView!
    
    // 디바이스 별 레이아웃
    @IBOutlet var heightCollection: [NSLayoutConstraint]!
    @IBOutlet weak var lastHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet weak var quizWidth: NSLayoutConstraint!
    @IBOutlet weak var playWidth: NSLayoutConstraint!
    @IBOutlet weak var exerciseBottomConst: NSLayoutConstraint!
    @IBOutlet weak var bongTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var progressViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var animationView: UIView!
    
    
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 2.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var coinView: UIView! {
        didSet {
            coinView.layer.cornerRadius = 4.0
            coinView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var cardListView: UIView! {
        didSet {
            cardListView.layer.cornerRadius = 4.0
            cardListView.clipsToBounds = true
        }
    }
    
    
    // Data
    @IBOutlet weak var userCharView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var expMaxLabel: UILabel!
    @IBOutlet weak var expCurrentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myCardsCount: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        setBackGroundImageForTime()
      
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
//        UIView.animate(withDuration: 0.6, delay: 2, options: [.repeat, .autoreverse], animations: {
//            [weak self] in
//           self?.firstButton.frame.origin.y -= 10
//        }) { (action) in
//            print("핸들러")
//        }
        
        
        print("여기서 체크하고 넘기고 토스트")
        
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
            myCardsCount.text = "00\(count)"
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
    }
    
    
    // safeArea 사용
 
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            heightCollection.forEach({ (height) in
                height.constant = 100
            })
            lastHeight.constant = 104
            viewLeading.constant = 56
            viewTrailing.constant = 56
            quizWidth.constant = 130
            playWidth.constant = 130
            exerciseBottomConst.constant = 24
            bongTopConstraint.constant = 50
        }
        
        if Constants.DeviceType.IS_IPHONE_6P {
            quizWidth.constant = 150
            playWidth.constant = 150
            progressViewLeading.constant = 12
            userNameLabelTrailing.constant = 24
        }
    }
    
    // 시간에 따른 배경화면 변경
    func setBackGroundImageForTime() {
        if let currentTime = TimeFormatter().getCurrentTime() {
            // 기본이 낮이기 때문에 밤일 때만 바꿔주면 된다.
            if currentTime >= 19 || currentTime < 6 {
                mainBackgroundImage.image = UIImage(named:"img_mainbg_PM")
            }
        }
    }
    
    
    // 공지사항 클릭
    @IBAction func presentNotice(_ sender: UIButton) {
        if let notice = storyboard?.instantiateViewController(withIdentifier: "NoticeViewController") as? NoticeViewController {
            self.present(notice, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func playExercise(_ sender: UIButton) {
        print("준비운동")
    }
    
    @IBAction func playAdventure(_ sender: UIButton) {
        print("도시탐험")
    }
    
    @IBAction func playQuiz(_ sender: UIButton) {
        print("퀴즈")
    }
    
    @IBAction func playGame(_ sender: UIButton) {
        print("놀이")
    }
    
    @IBAction func playStory(_ sender: UIButton) {
        print("동화")
    }
    
    
    
    
    
    
}
