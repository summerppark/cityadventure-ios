//
//  MainViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainBackgroundImage: UIImageView!
    
    
    @IBOutlet var heightCollection: [NSLayoutConstraint]!
    @IBOutlet weak var lastHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    
    
    @IBOutlet weak var quizWidth: NSLayoutConstraint!
    
    @IBOutlet weak var playWidth: NSLayoutConstraint!
    
    @IBOutlet weak var exerciseBottomConst: NSLayoutConstraint!
    
    @IBOutlet weak var bongTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        setBackGroundImageForTime()
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
    
}
