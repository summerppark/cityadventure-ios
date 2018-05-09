//
//  AdventureQRCodeViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
