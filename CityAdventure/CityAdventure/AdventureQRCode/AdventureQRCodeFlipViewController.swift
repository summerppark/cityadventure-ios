//
//  AdventureQRCodeFlipViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeFlipViewController: BaseViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var frontView: UIView! {
        didSet {
            frontView.layer.cornerRadius = 8.0
            frontView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var customCloseButton: UIButton! {
        didSet {
           customCloseButton.layer.cornerRadius = customCloseButton.frame.width / 2
            customCloseButton.layer.borderWidth = 2.0
            
            customCloseButton.layer.borderColor = UIColor.white.cgColor
            customCloseButton.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var frontRoundView: UIView! {
        didSet {
            frontRoundView.layer.cornerRadius = 16.0
            frontRoundView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 8.0
            backView.clipsToBounds = true
        }
    }
    @IBOutlet weak var backRoundView: UIView! {
        didSet {
            backRoundView.layer.cornerRadius = 8.0
                backRoundView.clipsToBounds = true
        }
    }
    
    
    var flipToggle: Bool = false
    
    
    var cityNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cityNumber , " is result" )
        backView.isHidden = true
        
    }
    
   
    @IBAction func filpView(sender: UIButton) {
        if flipToggle {
            // 앞면으로
            flipToggle = false
            frontView.isHidden = false
            backView.isHidden = true
        UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        } else {
            // 뒷면으로
            flipToggle = true
            // 앞면 숨긴다.
            backView.isHidden = false
            frontView.isHidden = true
            UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)

        }
    }
}
