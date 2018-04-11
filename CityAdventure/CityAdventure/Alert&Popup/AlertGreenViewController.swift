//
//  AlertGreenViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AlertGreenViewController: UIViewController {
    
    @IBOutlet weak var alertTitle: UILabel! {
        didSet {
            alertTitle.text = titleText
            alertTitle.attributedText =  NSMutableAttributedString(string: alertTitle.text!, attributes: strokeTextAttributes)
        }
    }
    @IBOutlet weak var alertDesc: UILabel! {
        didSet {
            alertDesc.text = descText
        }
    }
    
    @IBOutlet weak var okButton: UIButton! {
        didSet {
            okButton.layer.cornerRadius = 8.0
            okButton.clipsToBounds = true
            okButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        }
    }
    
    // 성공시 unwind를 걸기 위한 페이크.
    @IBOutlet weak var unWindButton: UIButton! {
        didSet {
            unWindButton.layer.cornerRadius = 8.0
            unWindButton.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var alertView: UIView! {
        didSet {
            alertView.layer.cornerRadius = 8.0
            alertView.clipsToBounds = true
        }
    }
    
    // 타이틀 스트로크 설정
    let strokeTextAttributes = [
        NSAttributedStringKey.strokeColor : UIColor.strokeGreenColor,
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.strokeWidth : -4.0,
        NSAttributedStringKey.font : UIFont(name: "GodoB", size: 22)!
        ] as [NSAttributedStringKey : Any]
    
    var titleText: String = ""
    var descText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleText == "비밀번호 변경 성공" {
            unWindButton.isHidden = false
            okButton.isHidden = true
        } else {
            unWindButton.isHidden = true
            okButton.isHidden = false
        }
    }
    
    @objc func close() {
        self.dismiss(animated: false)
    }
}
