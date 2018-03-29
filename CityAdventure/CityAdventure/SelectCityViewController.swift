//
//  SelectCityViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 29..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class SelectCityViewController: UIViewController {
    
    var titleString: String?
    
    @IBOutlet weak var cityView: UIView! {
        didSet {
            cityView.layer.borderWidth = 5.0
            cityView.layer.borderColor = UIColor.ultraLightGray.cgColor
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButtonLayout()
        layoutCheck()
        
    }
    
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImageView.snp.trailing).offset(-4)
            make.centerY.equalTo(bgImageView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            heightConstraint.constant = 400
            
        }
    }
    
    @IBAction func closeSelectCity(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
