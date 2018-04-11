//
//  RightSideMenuViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class RightSideMenuViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        print("ASD")
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, animations: {
             self.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (finished) in
            
            self.view.removeFromSuperview()
        }
    }
}
