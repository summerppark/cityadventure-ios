//
//  RightSideMenuViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class RightSideMenuViewController: BaseViewController {
    
    @IBOutlet weak var leftView: UIView!
    
    
    @IBOutlet weak var bgmSoundButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var effectSoundButtonHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        addGesture()
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCloseButton))
        leftView.addGestureRecognizer(tapGesture)
    }
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
        }
        
        if Constants.DeviceType.IS_IPHONE_6P {
        }
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.leftView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        print("ASD")
        self.leftView.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, animations: {
             self.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (finished) in
            
            self.view.removeFromSuperview()
        }
    }
}
