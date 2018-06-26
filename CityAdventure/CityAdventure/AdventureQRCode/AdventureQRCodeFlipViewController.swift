//
//  AdventureQRCodeFlipViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

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
    @IBOutlet weak var frontBackGround: UIImageView! {
        didSet {
            
        }
    }
    
    
    @IBOutlet weak var backBackGround: UIImageView! {
        didSet {
            
        }
    }
    
    
    // FRONT VIEW
    @IBOutlet weak var frontView: UIView! {
        didSet {
            frontView.backgroundColor = .clear
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
    
    
    
    @IBOutlet weak var firstLandMark: UIImageView! {
        didSet {
            firstLandMark.layer.cornerRadius = 8.0
            firstLandMark.layer.borderWidth = 3.0
            firstLandMark.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            firstLandMark.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var middleLandMark: UIImageView! {
        didSet {
            middleLandMark.layer.cornerRadius = 8.0
            middleLandMark.layer.borderWidth = 3.0
            middleLandMark.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            middleLandMark.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var lastLandMark: UIImageView! {
        didSet {
            lastLandMark.layer.cornerRadius = 8.0
            lastLandMark.layer.borderWidth = 3.0
            lastLandMark.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            lastLandMark.clipsToBounds = true
        }
    }
    
    
    // BACK VIEW
    
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 8.0
            backView.clipsToBounds = true
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
    @IBOutlet weak var backMaplocationButton: UIButton! {
        didSet {
            backMaplocationButton.layer.cornerRadius = 8.0
            backMaplocationButton.layer.borderWidth = 8.0
            backMaplocationButton.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            backMaplocationButton.clipsToBounds = true
        }
    }
    
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
        
        
        backView.isHidden = true
        
        
        // 제스쳐 등록
        addGestureRecognizerImages()
        
        
        
        // Imageload Front
        // cityNumber
        //
        // 이미지 셋팅
        setImagesAllContents(cityNumbers: String(cityNumber.dropLast()))
        
        //텍스트 데이타 셋팅
        setTextDataSetting()
      
    }
    
    func setTextDataSetting() {
        
    }
    
    func addGestureRecognizerImages() {
        // HelpImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideHelpView))
        helpImage.addGestureRecognizer(tapGesture)
        // Swipe Gesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture.direction = .left
        let swipeGesture2 = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture2.direction = .right
        mainView.addGestureRecognizer(swipeGesture)
        mainView.addGestureRecognizer(swipeGesture2)
        
        infoView.isUserInteractionEnabled = true
        let infoTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedInfoView))
        infoView.addGestureRecognizer(infoTapGesture)
        
        // LandMark
        let tappedLandmark = UITapGestureRecognizer(target: self, action: #selector(landmark(sender:)))
        firstLandMark.addGestureRecognizer(tappedLandmark)
        let tappedLandmark2 = UITapGestureRecognizer(target: self, action: #selector(landmark(sender:)))
        middleLandMark.addGestureRecognizer(tappedLandmark2)
        let tappedLandmark3 = UITapGestureRecognizer(target: self, action: #selector(landmark(sender:)))
        lastLandMark.addGestureRecognizer(tappedLandmark3)
    }
    
    @objc func landmark(sender: UITapGestureRecognizer) {
        print(sender.view?.tag)
    }
    
    
    func setImagesAllContents(cityNumbers: String) {
        // 전면 앞
        
        print("ㅉ", DataManager.shared.cityCards.count)
    
        var imageNumber: String = ""
        
        if let number = Int(cityNumbers) {
            if number < 10 {
                imageNumber = "00\(number)"
            } else if number < 100 {
                imageNumber = "0\(number)"
            } else {
                imageNumber = String(number)
            }
        }
      
        
        frontImageView.kf.setImage(with: URL(string: APIUrls.getImageFlipFront(cardNumber: imageNumber)))
        
        
        backMaplocationButton.kf.setImage(with:  URL(string: APIUrls.getImageMinimap(cardNumber: cityNumbers)), for: .normal)
        
        // LandMark 이미지
        self.firstLandMark.kf.setImage(with: URL(string:APIUrls.getImagelandMark(cardNumber: cityNumbers, index: "1")))
        self.middleLandMark.kf.setImage(with: URL(string:APIUrls.getImagelandMark(cardNumber: cityNumbers, index: "2")))
        self.lastLandMark.kf.setImage(with: URL(string:APIUrls.getImagelandMark(cardNumber: cityNumbers, index: "3")))
        
        
        // LandMark 이름
        

    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        print("Swipe")
        switch sender.direction {
        case .left:
            print("레프트")
            
            if !flipToggle {
                flipToggle = true
                backView.isHidden = false
                frontView.isHidden = true
                UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        case .right:
            print("라이트")
            if flipToggle {
                flipToggle = false
                frontView.isHidden = false
                backView.isHidden = true
                UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeTextSoundViewController") as? AdventureQRCodeTextSoundViewController {
            alert.modalPresentationStyle = .overFullScreen

            self.present(alert, animated: false)
        }
    }
    
    
    @IBAction func tappedSpeechButton(_ sender: UIButton) {
        
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeTTSDescViewController") as? AdventureQRCodeTTSDescViewController {
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false)
        }
    }
    
    @IBAction func tappedPuzzle(_ sender: UIButton) {
        if let puzzle = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodePuzzleViewController") as? AdventureQRCodePuzzleViewController {
            
            // 어떤 도시인지 숫자를 알려주어야 함
            puzzle.puzzleCity = "3"
            self.navigationController?.pushViewController(puzzle, animated: true)
        }
    }
}


extension AdventureQRCodeFlipViewController: UITextViewDelegate {

}
