//
//  AdventureQRCodeFlipViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


class AdventureQRCodeFlipViewController: BaseViewController {
    
    @IBOutlet weak var flipButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var helpButton: UIButton! {
        didSet {
            helpButton.addTarget(self, action: #selector(helpView), for: .touchUpInside)
        }
    }
    
    // FRONT VIEW
    @IBOutlet weak var frontView: UIView! {
        didSet {
            frontView.layer.cornerRadius = 8.0
            frontView.clipsToBounds = false
//            frontView.layer.masksToBounds = false
//            frontView.layer.shadowColor = UIColor.darkGray.cgColor
//
//            // 그림자 농도?
//            frontView.layer.shadowOpacity = 0.5
//            frontView.layer.shadowOffset = CGSize(width: 5, height: 5)
//            frontView.layer.shadowRadius = 8.0
//            frontView.layer.shadowPath = UIBezierPath(rect: frontView.bounds).cgPath
//            frontView.layer.shouldRasterize = true
        }
    }
    
    @IBOutlet weak var frontImageView: UIImageView! {
        didSet {
            frontImageView.layer.cornerRadius = 8.0
            frontImageView.clipsToBounds = true
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
    
    
    @IBOutlet weak var travelInfoButton: UIButton!
    
    @IBOutlet weak var nationInfoButton: UIButton!
    
    
    
    // BACK VIEW
    
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 8.0
            backView.clipsToBounds = true

//            backView.layer.masksToBounds = false
//            backView.layer.shadowColor = UIColor.gray.cgColor
//            backView.layer.shadowOpacity = 1
//            backView.layer.shadowOffset = CGSize(width: 5, height: 5)
//            backView.layer.shadowRadius = 8.0
//
//            backView.layer.shadowPath = UIBezierPath(rect: backView.bounds).cgPath
//            backView.layer.shouldRasterize = true
            
        }
    }
    
    
    @IBInspectable
    @IBOutlet weak var backMaplocationButton: UIButton!
    
    
    
    
    // BOTTOM
    var helpImage: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 24, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-24))
        iv.image = #imageLiteral(resourceName: "icon_qrcode_help")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let backGroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    @IBOutlet var bottomMaps: [UIButton]!
    
    var flipToggle: Bool = false
    var cityNumber: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cityNumber , " is result" )
        backView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideHelpView))
        helpImage.addGestureRecognizer(tapGesture)
        
        
        bottomMaps.forEach { (btn) in
            btn.layer.cornerRadius = 8.0
            btn.layer.borderWidth = 3.0
            btn.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            btn.clipsToBounds = true
        }
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
    
    @objc func helpView() {
        
        if Constants.DeviceType.IS_IPHONE_X {
            helpImage = UIImageView(frame: CGRect(x: 0, y: 46, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-46-32))
            helpImage.image = #imageLiteral(resourceName: "icon_qrcode_help")
            helpImage.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideHelpView))
            helpImage.addGestureRecognizer(tapGesture)
        }
        
        self.view.addSubview(backGroundView)
        self.view.addSubview(helpImage)
    }
    
    @objc func hideHelpView() {
        backGroundView.removeFromSuperview()
        helpImage.removeFromSuperview()
    }
}
