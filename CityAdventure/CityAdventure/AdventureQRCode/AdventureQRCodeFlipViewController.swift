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
    
    
    @IBOutlet weak var travelInfoButton: UIButton! {
        didSet {
            travelInfoButton.addTarget(self, action: #selector(presentWebView), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var nationInfoButton: UIButton! {
        didSet {
            nationInfoButton.addTarget(self, action: #selector(presentBoard), for: .touchUpInside)
        }
    }
    
    
    
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
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.cornerRadius = closeButton.frame.width / 2
            closeButton.layer.borderWidth = 2.0
            
            closeButton.layer.borderColor = UIColor.white.cgColor
            closeButton.clipsToBounds = true
        }
    }
    
    @IBInspectable
    @IBOutlet weak var backMaplocationButton: UIButton!
    
    @IBOutlet weak var backborderView: UIView! {
        didSet {
            backborderView.layer.cornerRadius = 8.0
            backborderView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var backBorderInnterView: UIView! {
        didSet {
            backBorderInnterView.layer.cornerRadius = 8.0
            backBorderInnterView.clipsToBounds = true
        }
    }
    
    
    
    // BOTTOM
    var helpImage: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 24, y: 24, width: UIScreen.main.bounds.width-48, height: UIScreen.main.bounds.height-48))
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
    
    
    @IBOutlet weak var infoView: UIView!
    
    
    
    
    var flipToggle: Bool = false
    var cityNumber: String = ""

    
    @IBOutlet weak var bottomTextView: UITextView! {
        didSet {
            bottomTextView.delegate = self
            bottomTextView.font = UIFont(name: "GodoM", size: 10.0)
        }
    }
    
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
        
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture.direction = .left
        let swipeGesture2 = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture2.direction = .right
        mainView.addGestureRecognizer(swipeGesture)
        mainView.addGestureRecognizer(swipeGesture2)
        
        
        infoView.isUserInteractionEnabled = true
        let infoTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedInfoView))
        infoView.addGestureRecognizer(infoTapGesture)
        
    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        print("Swipe")
        switch sender.direction {
        case .left:
            print("레프트")
            
            if flipToggle {
                flipToggle = false
                frontView.isHidden = false
                backView.isHidden = true
                UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            }
            
            
        case .right:
            print("라이트")
            
            if !flipToggle {
                flipToggle = true
                backView.isHidden = false
                frontView.isHidden = true
                UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
            
        default:
            break
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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

            helpImage.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideHelpView))
            helpImage.addGestureRecognizer(tapGesture)
        }
        
        if flipToggle {
            helpImage.image = #imageLiteral(resourceName: "img_help_back")
            
        } else {
            helpImage.image = #imageLiteral(resourceName: "icon_qrcode_help")
        }
        
        self.view.addSubview(backGroundView)
        self.view.addSubview(helpImage)
    }
    
    @objc func hideHelpView() {
        backGroundView.removeFromSuperview()
        helpImage.removeFromSuperview()
    }
    
    // 여행정보 보여주기
    @objc func presentWebView() {
        if let travelInfo = storyboard?.instantiateViewController(withIdentifier: "AvdentureQRCodeTravelInfo") as? AvdentureQRCodeTravelInfo {
            
            let navigationController = UINavigationController(rootViewController: travelInfo)
            self.present(navigationController, animated: true, completion: nil)
            
        }
    }
    
    
    // 해당 도시의 정보를 보여주는 뷰.
    @objc func presentBoard() {
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeBoardPopUp") as? AdventureQRCodeBoardPopUp {
            alert.modalPresentationStyle = .overFullScreen
            
            alert.titleString = "부산의 면적은 1000㎢ 입니다."
            alert.subTitleString = "님자: 9,000,000명, 여자: 2,000,000명\n 부산의 인구는 약 1100만명"
            alert.fmCount = 200
            alert.mCount = 900
            
            self.present(alert, animated: false)
        }
    }
    
    
    // 한자 한글 읽어주기
    @objc func tappedInfoView() {
        print("Tapped")
    }
}


extension AdventureQRCodeFlipViewController: UITextViewDelegate {

}
