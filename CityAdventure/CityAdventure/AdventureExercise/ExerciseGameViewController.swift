 //
 //  ExerciseGameViewController.swift
 //  CityAdventure
 //
 //  Created by Jiyong on 2018. 4. 20..
 //  Copyright © 2018년 bubu. All rights reserved.
 //
 
 import UIKit
 import Toaster
 import AVFoundation
 
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
    var answerArray: [String] = ["", "", ""]
    var randomCharArray: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        
    }
    
    // 셋팅
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("stage" , stageNumber)
        setPuzzleButton(stageNumber: stageNumber)
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
        
        // 글자를 소리내주는 부분
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: sender.currentTitle!)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        
        synthesizer.speak(utterance)
        
        
        // 8개의 버튼을 누를 때 마다 정답 배열에 앞에서부터 체크한다.
        
        
        // 정답배열에 추가
        if charButtons[sender.tag].backgroundColor == .white {
            // 정답배열에 추가 된 버튼의 색은 회색으로 설정.
            charButtons[sender.tag].backgroundColor = .darkGray
            
            // 정답이 몇글자 인지 체크
            if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
                
                // 정답을 가지고 있는 배열
                if answerArray[0] == "" {
                    answerArray[0] = sender.currentTitle!
                } else {
                    answerArray[1] = sender.currentTitle!
                }
                
                // 3 글자일 때
            } else {
                if answerArray[0] == "" {
                    answerArray[0] = sender.currentTitle!
                } else if answerArray[1] == "" {
                    answerArray[1] = sender.currentTitle!
                } else {
                    answerArray[2] = sender.currentTitle!
                }
            }
            
            
            // 정답배열에서 제거
        } else {
            charButtons[sender.tag].backgroundColor = .white
            // 정답이 몇글자 인지 체크
            if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
                
                if sender.currentTitle! == answerArray[0] {
                    answerArray[0] = ""
                } else {
                    answerArray[1] = ""
                }
                
            } else {
                if sender.currentTitle! == answerArray[0] {
                    answerArray[0] = ""
                } else if sender.currentTitle! == answerArray[1] {
                    answerArray[1] = ""
                } else {
                    answerArray[2] = ""
                }
            }
        }
        
        
        
        print(answerArray.joined(), "현재 정답")
        inputAnswerButtons()
        
    }
    
    func inputAnswerButtons() {
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
            answerButton[0].setTitle(answerArray[0], for: .normal)
            answerButton[1].setTitle(answerArray[1], for: .normal)
        } else {
            answerThreeButton[0].setTitle(answerArray[0], for: .normal)
            answerThreeButton[1].setTitle(answerArray[1], for: .normal)
            answerThreeButton[2].setTitle(answerArray[2], for: .normal)
        }
        
        if answerArray.joined().count == DataManager.shared.citynumbers[stageNumber].cityName.count {
            
            checkAnswer()
        }
    }
    
    func checkAnswer() {
        
        if answerArray.joined() == DataManager.shared.citynumbers[stageNumber].cityName {
            gameResult(result: true)
            
        } else {
            print("실패")
            gameResult(result: false)

        }
    }
    
    func gameResult(result: Bool) {
        if result {
            if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
                // 스테이지 상태를 로컬에 저장한다.
                
                // 최종으로 깬 스테이지가 지금 깬 스테이지보다 작을때만 로컬에 갱신한다.
                
                if stageNumber+1 > UserDefaults.standard.integer(forKey: "\(name)_exerciseStage") {
                    UserDefaults.standard.set(stageNumber+1, forKey: "\(name)_exerciseStage")
                }
            }
            
            //성공일 때
            if let correct = storyboard?.instantiateViewController(withIdentifier: "ResultCorrectPopUp") as? ResultCorrectPopUp {
                correct.modalPresentationStyle = .overFullScreen
                correct.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                correct.delegate = self
                self.present(correct, animated: false) {
                    self.answerButtonsInit()
                }
            }
        } else {
            Toast.init(text: "\(answerArray.joined()) X , 다시 생각해 보세요!!").show()
            answerButtonsInit()
        }
    }
    
    func answerButtonsInit() {
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 2 {
            answerButton.forEach({ (btn) in
                btn.setTitle("", for: .normal)
            })
            answerArray = ["","",""]
            
            charButtons.forEach({ (btn) in
                btn.backgroundColor = .white
            })
            
        } else {
            answerThreeButton.forEach({ (btn) in
                btn.setTitle("", for: .normal)
            })
            answerArray = ["","",""]
            
            charButtons.forEach({ (btn) in
                btn.backgroundColor = .white
            })
            
        }
    }
    
    // 임시 힌트
    @IBAction func tappedHintButton(_ sender: UIButton) {
        if let hint = storyboard?.instantiateViewController(withIdentifier: "HintPopViewController") as? HintPopViewController {
            hint.modalPresentationStyle = .overFullScreen
            hint.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            //자음만
            self.present(hint, animated: false)
        }
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 }
 
 
 
 extension ExerciseGameViewController: ResultCorrectPopUpProtocol {
    func tappedBGView() {
        print("바탕을 눌렀다")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 다음으로 눌렀을 때
    func tappedNext() {
        stageNumber += 1
        print(stageNumber)
        setGame(stageNumber: stageNumber)
        setPuzzleButton(stageNumber: stageNumber)
    }
    
    func setGame(stageNumber: Int) {
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
    
    func setPuzzleButton(stageNumber: Int) {
        var count = 2
        
        if DataManager.shared.citynumbers[stageNumber].cityName.count == 3 {
            count = 3
        }
        
        // 중 복 제 거
        let charArray = Array(Set(DataManager.shared.randomChar.flatMap { $0 }))
       
        var sampleArray: [Int] = []
        var resultArray: [String] = []
        resultArray = DataManager.shared.citynumbers[stageNumber].cityName.map { String($0)
            
        }
      
        // 랜덤으로 글자배열을 만듬
        while resultArray.count < 8 {
            let num = Int(arc4random_uniform(UInt32(charArray.count-1)))
            resultArray.append(String(charArray[num]))
        }
        
        // 랜덤인덱스를 만듬
        while sampleArray.count < 8 {
            let num = Int(arc4random_uniform(8))
            if !sampleArray.contains(num) {
                sampleArray.append(num)
            }
        }
        
        for index in 0...charButtons.count-1 {
            charButtons[index].setTitle(String(resultArray[sampleArray[index]]), for: .normal)
        }
    }
 }
