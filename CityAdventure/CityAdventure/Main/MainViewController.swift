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
    
    
    @IBOutlet weak var animationView: UIView!
    
    
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 2.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        setBackGroundImageForTime()
      
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        UIView.animate(withDuration: 0.6, delay: 2, options: [.repeat, .autoreverse], animations: {
            [weak self] in
           self?.firstButton.frame.origin.y -= 10
        }) { (action) in
            print("핸들러")
        }
        
        
        print("여기서 체크하고 넘기고 토스트")
        print(DataManager.shared.getUserInfo()?.userInfo?.s_name)
        print(DataManager.shared.getUserAccountInfo()?.userAccountInfo?.s_email)
        print(DataManager.shared.getUserCardInfo()?.dataLength)
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
