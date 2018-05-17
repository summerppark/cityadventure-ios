//
//  AdventureQRCodeViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeViewController: BaseViewController {
    
    // 파랑색 네모 높이
    @IBOutlet weak var squareHeight: NSLayoutConstraint!
    @IBOutlet weak var textTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            
            // iPhone X 일 때 레이아웃
        }
        
        if Constants.DeviceType.IS_IPHONE_X || Constants.DeviceType.IS_IPHONE_6P {
            squareHeight.constant = 340
            textTopConstraint.constant = 78
        }
    
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
    
    
    @IBAction func goToQRCodeReader(_ sender: Any) {
        
        if let qrCodeReaderView = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeReaderViewController") as? AdventureQRCodeReaderViewController {
            self.navigationController?.pushViewController(qrCodeReaderView, animated: true)
        }
        
    }
    
    
}
