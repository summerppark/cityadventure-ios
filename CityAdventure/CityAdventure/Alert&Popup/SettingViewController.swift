//
//  SettingViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 16..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {
    
    var delegate: SettingViewProtocol?
    let sampleImages = [#imageLiteral(resourceName: "btn_check_gender"), #imageLiteral(resourceName: "btn_checkOn_gender")]
  
    @IBOutlet weak var settingView: UIView! {
        didSet {
            settingView.layer.cornerRadius = 16.0
            settingView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.addTarget(self, action: #selector(closeSettingView), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var locationView: UIView! {
        didSet {
            locationView.layer.cornerRadius = 8.0
            locationView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var pushAlarmView: UIView! {
        didSet {
            pushAlarmView.layer.cornerRadius = 8.0
            pushAlarmView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var locationOnImageView: UIImageView!
    @IBOutlet weak var locationOffImageView: UIImageView!
    @IBOutlet weak var pushNotiOnImageView: UIImageView!
    @IBOutlet weak var pushNotiOffImageView: UIImageView!
    
    
    @IBOutlet var iconsImage: [UIImageView]!
    
    
    @IBOutlet weak var bottomView: UIView!  {
        didSet {
            bottomView.layer.cornerRadius = 8.0
            bottomView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var leaveButton: UIButton! {
        didSet {
            let linkbuttonAttributes = [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
                                        NSAttributedStringKey.foregroundColor: UIColor.black
            
                ] as [NSAttributedStringKey : Any]
            let attributeString = NSMutableAttributedString(string: "회원탈퇴",                                                    attributes: linkbuttonAttributes)
            
            leaveButton.setAttributedTitle(attributeString, for: .normal)
            
            
            
        }
    }
    
    
    
    @IBAction func selectOption(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            iconsImage[0].image = sampleImages[1]
            iconsImage[1].image = sampleImages[0]
        case 1:
            iconsImage[0].image = sampleImages[0]
            iconsImage[1].image = sampleImages[1]
        case 2:
            iconsImage[2].image = sampleImages[1]
            iconsImage[3].image = sampleImages[0]
        case 3:
            iconsImage[2].image = sampleImages[0]
            iconsImage[3].image = sampleImages[1]
        default:
            break
        }
    }
    
    @objc func closeSettingView() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(settingView.snp.trailing).offset(-4)
            make.centerY.equalTo(settingView.snp.top).offset(4)
            make.width.height.equalTo(48)
        }
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        if let logoutAlert = storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") as? LogoutViewController {
            logoutAlert.modalPresentationStyle = .overFullScreen
            logoutAlert.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
            self.present(logoutAlert, animated: false, completion: nil)
        }
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.delegate?.resetPassword()
        }
    }
}

protocol SettingViewProtocol: class {
    func resetPassword()
}
