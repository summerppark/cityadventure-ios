 //
//  ExerciseGameViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 20..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
 
 class ExerciseGameViewController: BaseViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var cardCountView: UIView! {
        didSet {
            cardCountView.layer.cornerRadius = 16.0
            cardCountView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var getCardsStatus: UILabel!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet var charButtons: [UIButton]!
    @IBOutlet var answerButton: [UIButton]!
    
    @IBOutlet weak var twoCharStackView: UIStackView!
    @IBOutlet weak var threeCharStackView: UIStackView!
    @IBOutlet var answerThreeButton: [UIButton]!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var answerText: String = ""
    var stageNumber = 0
    var count = 0
    var answerArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    // 셋팅
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("stage" , stageNumber)
        // 힌트 DB에 있는거 가져오기.

        hintLabel.text = DataManager.shared.exerciseHintList[stageNumber].hint

        var stageImage = ""
     
        if stageNumber + 1 < 10 {
            stageImage = "00\(stageNumber+1)"
        } else if stageNumber + 1 < 100 {
            stageImage = "0\(stageNumber+1)"
        } else {
            stageImage = "\(stageNumber+1)"
        }
        
        // 상단에 몇번째 스테이지인지.
        getCardsStatus.text = "\(stageNumber+1) / 162"
 
        // 해당하는 카드를 로드.
        cardImage.image = UIImage(named: "card_thumbnail_\(stageImage)")
        
        
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 3 {
            threeCharStackView.isHidden = false
            twoCharStackView.isHidden = true
        } else {
            threeCharStackView.isHidden = true
            twoCharStackView.isHidden = false
        }
        
        print("정답" , DataManager.shared.citynumbers[stageNumber].cityName)
    }
    
    
    
    
    func layoutCheck() {
    
        charButtons.forEach { (btn) in
            btn.layer.cornerRadius = 8.0
            btn.clipsToBounds = true
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor().colorFromHex("#7d7d7d").cgColor
            btn.addTarget(self, action: #selector(tappedCharButton), for: .touchUpInside)
        }
        
        answerThreeButton.forEach { (btn) in
            btn.layer.cornerRadius = 8.0
            btn.clipsToBounds = true
            btn.layer.borderWidth = 1.6
            btn.layer.borderColor = UIColor().colorFromHex("#7d7d7d").cgColor
        }
        
        answerButton.forEach { (btn) in
            btn.layer.cornerRadius = 8.0
            btn.clipsToBounds = true
            btn.layer.borderWidth = 1.6
            btn.layer.borderColor = UIColor().colorFromHex("#7d7d7d").cgColor
            
        }
        
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
        
        if Constants.DeviceType.IS_IPHONE_X || Constants.DeviceType.IS_IPHONE_6P {
            imageHeight.constant = 320
        }
    }
    
    @objc func tappedCharButton(sender: UIButton) {
        print(sender.tag)
        
        if charButtons[sender.tag].backgroundColor == .white {
            charButtons[sender.tag].backgroundColor = .darkGray
            answerText += charButtons[sender.tag].currentTitle!
            answerArray.append("\(charButtons[sender.tag].currentTitle!)")
        } else {
            charButtons[sender.tag].backgroundColor = .white
            count -= 1
            answerArray.removeLast()
            answerText.removeLast()
        }
        
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
            answerButton[count].setTitle( answerArray.count == 0 ? "" : answerArray[count], for: .normal)
        } else {
            answerThreeButton[count].setTitle(answerArray[count], for: .normal)
        }
        
        
        
        count += 1
        
        
        if answerArray.count == Int(DataManager.shared.citynumbers[stageNumber].cityName.count) {
            checkAnswer()
        }
        
    }
    
    func checkAnswer() {
        print("정답인지 아닌지 체크 ")
        charButtons.forEach { (btn) in
            btn.backgroundColor = UIColor.white
        }
        
        
        
        if answerArray.joined() == DataManager.shared.citynumbers[stageNumber].cityName {
            print("정답")
        } else {
            print("오답")
        }
        
        
        
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
            answerButton.forEach({ (btn) in
                btn.setTitle("", for: .normal)
            })
        } else {
            answerThreeButton.forEach({ (btn) in
                btn.setTitle("", for: .normal)
            })
        }
        
        count = 0
        answerArray.removeAll()
        answerText = ""
        
    }
    
    // 임시 힌트
    @IBAction func tappedHintButton(_ sender: UIButton) {
        twoCharStackView.isHidden = true
        threeCharStackView.isHidden = false
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 }
