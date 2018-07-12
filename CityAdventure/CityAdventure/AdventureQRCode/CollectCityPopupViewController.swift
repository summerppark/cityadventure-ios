//
//  CollectCityPopupViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 20..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class CollectCityPopupViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var cityName: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        closeButtonLayout()
        
        if let name = cityName {
            resultLabel.text = "축하합니다!\n\(name) 카드를 획득했습니다."
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(mainView.snp.trailing).offset(-4)
            make.centerY.equalTo(mainView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
 
    
    
}
