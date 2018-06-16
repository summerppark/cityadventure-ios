//
//  AdventureQRCodeTextSoundViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 14..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import AVFoundation

class AdventureQRCodeTextSoundViewController: BaseViewController {
    
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor().colorFromHex("#fcf5d3")
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var chinaTextView: UIView! {
        didSet {
            chinaTextView.layer.cornerRadius = 8.0
            chinaTextView.layer.borderWidth = 2.0
            chinaTextView.layer.borderColor = UIColor().colorFromHex("#e3d8a4").cgColor
        }
    }
    
    
    @IBOutlet weak var koreaTextView: UIView! {
        didSet {
            koreaTextView.layer.cornerRadius = 8.0
            koreaTextView.layer.borderWidth = 2.0
            koreaTextView.layer.borderColor = UIColor().colorFromHex("#e3d8a4").cgColor
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false , completion: nil)
    }
    
    @IBAction func soundplay(_ sender: UIButton) {
    
        if sender.tag == 15 {
            
            let utterance = AVSpeechUtterance(string: "가마 부 뫼 산")
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            utterance.rate = 0.4
            LaunchScreenViewController.syntheSizer.speak(utterance)
        } else {
            let utterance = AVSpeechUtterance(string: "부산")
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            utterance.rate = 0.4
            LaunchScreenViewController.syntheSizer.speak(utterance)
        }
    }
    
    
}
