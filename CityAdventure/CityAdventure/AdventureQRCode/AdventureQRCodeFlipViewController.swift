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
import Alamofire

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


class AdventureQRCodeFlipViewController: BaseViewController {
    //탑뷰
    @IBOutlet weak var userCharView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var expMaxLabel: UILabel!
    @IBOutlet weak var expCurrentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myCardsCount: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 1.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var progressViewLeading: NSLayoutConstraint!
    @IBOutlet weak var userNameLabelTrailing: NSLayoutConstraint!
    
    
    //////
    
    @IBOutlet weak var puzzleButton: UIButton!
    
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
    
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var frontCityName: UILabel!
    
    // FRONT VIEW
    @IBOutlet weak var frontView: UIView! {
        didSet {
            frontView.backgroundColor = .clear
            frontView.layer.cornerRadius = 8.0
            frontView.clipsToBounds = false
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
            travelInfoButton.titleLabel?.font = UIFont(name: "GodoM", size: 14.0)
            travelInfoButton.addTarget(self, action: #selector(presentWebView), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var nationInfoButton: UIButton! {
        didSet {
            nationInfoButton.titleLabel?.font = UIFont(name: "GodoM", size: 14.0)
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
    
    
    @IBOutlet weak var leadingCityNameConstant: NSLayoutConstraint!
    
    var kanjiStrArray :[String] = []
    
    
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
    
    
    @IBOutlet weak var cityArea: UILabel! // 광역시
    @IBOutlet weak var cityName: UILabel! // 부산
    @IBOutlet weak var cityKanji: UILabel! // 한자
    @IBOutlet weak var kanjiExplain: UILabel! // 가마부 뫼산
    @IBOutlet weak var sloganTitle: UILabel!
    
    
    @IBOutlet weak var landmark_first: UILabel!
    
    @IBOutlet weak var landmark_second: UILabel!
    
    @IBOutlet weak var landmark_third: UILabel!
    
    
    var landmarkTuple = [(Int, String)]()
    
    var travelInfoUrl = ""
    var cityType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dump(DataManager.shared.getUserCardInfo()?.cardInfo)
        backView.isHidden = true
        
        
        // 제스쳐 등록
        addGestureRecognizerImages()
        dataSetting()
        layoutCheck()
        
        // Imageload Front
        // cityNumber
        //
        // 이미지 셋팅
        setImagesAllContents(cityNumbers: String(cityNumber.dropLast()))
        
        //텍스트 데이타 셋팅
        
        if let index = Int(String(cityNumber.dropLast())) {
            print(index ," index")
            setTextDataSetting(index: index-1)
        }
    
        // 뒷장일 경우 바로 뒷면을 보여준다.
        if String(cityNumber.removeLast()) == "b" {
           presentBackView()
        }
        
        DataManager.shared.getUserCardInfo()?.cardInfo?.forEach({ (cardInfo) in
            if let no = cardInfo.uti_cardNo {
                if no == Int(cityNumber) {
                    print("획득한 카드")
                    puzzleButton.setImage(#imageLiteral(resourceName: "btn_collected_city"), for: .normal)
                }
            }
        })
        
        Alamofire.request(APIUrls.getLandmarks(number: cityNumber), method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            if let result = response.result.value as? NSDictionary, let any = result["data"] as? NSArray {
                
                any.forEach({ (data) in
                    if let dic = data as? NSDictionary, let no = dic["no"] as? Int, let name = dic["s_name"] as? String {
                        self.landmarkTuple.append((no,name))
                    }
                })
            }
            DispatchQueue.main.async { [weak self] in
                self?.landmark_first.text = self?.landmarkTuple[0].1
                self?.landmark_second.text = self?.landmarkTuple[1].1
                self?.landmark_third.text = self?.landmarkTuple[2].1
            }
        }
 
        layoutColor(cityNumber: cityType)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSetting()
    }
    
    func layoutColor(cityNumber: Int) {
        print(cityNumber,"flipView")
        
            let cityColor = UIColor().cityTypeColor(province: cityNumber)
            // 밑에 배경색

           backborderView.backgroundColor = cityColor
            speakButton.setImage(UIImage(named: "icon_sound_\(cityNumber)"), for: .normal)
            
            firstLandMark.layer.borderColor = cityColor.cgColor
            middleLandMark.layer.borderColor = cityColor.cgColor
            lastLandMark.layer.borderColor = cityColor.cgColor
            backMaplocationButton.layer.borderColor = cityColor.cgColor
    }
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P {
            progressViewLeading.constant = 12
            userNameLabelTrailing.constant = 24
            leadingCityNameConstant.constant = 36
        }
    }
    
    func presentBackView() {
        flipToggle = true
        backView.isHidden = false
        frontView.isHidden = true
        UIView.transition(with: mainView, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func setTextDataSetting(index: Int) {
        let city = DataManager.shared.cityCards[index]
        var kanjiString = ""
        var kanjiText = ""
        
        if city.s_name.count == 2 {
            city.s_kanji.forEach { (char) in
                kanjiString += "\(char)     "
                kanjiText += "\(char)"
            }
            kanjiStrArray = city.t_kanjiExplain.components(separatedBy: ",")
            cityKanji.text = String(kanjiString.dropLast(5))
            kanjiStrArray.append(kanjiText)
            kanjiStrArray.append(city.s_name)
        } else {
            
            city.s_kanji.forEach({ (char) in
                kanjiString += "\(char)     "
                kanjiText += "\(char)"
            })
            //0,1,2
            kanjiStrArray = city.t_kanjiExplain.components(separatedBy: ",")
            //3
            kanjiStrArray.append(kanjiText)
            
            //4
            kanjiStrArray.append(city.s_name)
            cityKanji.text = String(kanjiString.dropLast(5))
        }
        
        
        kanjiExplain.text = city.t_kanjiExplain.replacingOccurrences(of: ",", with: "   ")
        
        
        frontCityName.text = "\(city.s_name) \(city.s_type)"
        cityArea.text = city.s_type
        cityName.text = city.s_name
        
        sloganTitle.text = city.t_slogan

        bottomTextView.attributedText = city.t_cityExplain.convertHtml()
        bottomTextView.font = UIFont.init(name: "GodoM", size: 12.0)
        
        travelInfoUrl = city.t_tourURL
        cityType = Int(city.ui_province)
        
    }
    
    // 상단 뷰 데이타 셋팅
    func dataSetting() {
        guard let currentExp = DataManager.shared.getUserInfo()?.userInfo?.ui_exp else {
            return
        }
        
        
        let level = super.getLevel(exp: currentExp)
        let curExp = super.getAbsExp(exp: currentExp)
        let maxExp = super.getNextNeedExpByLevel(level: level)
        
        // 현재 레벨을 표현해준다.
        currentLevelLabel.text = "\(level)"
        expCurrentLabel.text = "\(curExp)"
        expMaxLabel.text = "\(maxExp)"
        
        print("level = ", level)
        print("currentExp = ", super.getAbsExp(exp: currentExp))
        print("maxExp = ", super.getNextNeedExpByLevel(level: level))
        
        if let coin = DataManager.shared.getUserInfo()?.userInfo?.ui_credit {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            myCoin.text = nf.string(from: NSNumber(integerLiteral: coin))
        }
        
        if let count = DataManager.shared.getUserCardInfo()?.dataLength {
            var str = ""
            if count < 10 {
                str = "00\(count)"
            } else if count < 100 {
                str = "0\(count)"
            } else {
                str = "\(count)"
            }
            
            myCardsCount.text = str
        }
        
        if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
            userNameLabel.text = name
        }
        
        
        if let index = DataManager.shared.getUserInfo()?.userInfo?.ui_avatarNo {
            print(index)
            userCharView.image = super.charImages[index-1]
        }
        
        // 프로그레스 뷰 상태를 셋팅
        progressView.progress = (Float(curExp)/Float(maxExp))
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
        
        if let landmark = self.storyboard?.instantiateViewController(withIdentifier: "LandMarkDetailViewController") as? LandMarkDetailViewController, let index = sender.view?.tag {
            
            landmark.landmarkNumber = landmarkTuple[index-1].0
            self.navigationController?.pushViewController(landmark, animated: true)
        }
        
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
            travelInfo.travelInfoUrl = travelInfoUrl
            let navigationController = UINavigationController(rootViewController: travelInfo)
            self.present(navigationController, animated: true, completion: nil)
            
        }
    }
    
    
    // 해당 도시의 정보를 보여주는 뷰.
    @objc func presentBoard() {
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeBoardPopUp") as? AdventureQRCodeBoardPopUp {
            alert.modalPresentationStyle = .overFullScreen
            alert.cityNumber = cityNumber
            alert.cityName = self.cityName.text ?? ""
            self.present(alert, animated: false)
        }
    }
    
    
    // 한자 한글 읽어주기
    @objc func tappedInfoView() {
        print("Tapped")
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeTextSoundViewController") as? AdventureQRCodeTextSoundViewController {
            print("TEst",kanjiStrArray)
            
            if let name = kanjiStrArray.last, name == "서울" {
                kanjiStrArray.insert("  ", at: 2)
            }
            
            alert.strArray = self.kanjiStrArray
            alert.number = cityNumber
            
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false)
        }
    }
    
    
    @IBAction func tappedSpeechButton(_ sender: UIButton) {
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeTTSDescViewController") as? AdventureQRCodeTTSDescViewController {
            alert.cityTitleString = self.sloganTitle.text ?? "nil"
            alert.cityNumber = cityNumber
            alert.cityType = self.cityType
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false)
        }
    }
    
    @IBAction func tappedPuzzle(_ sender: UIButton) {
        if let puzzle = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodePuzzleViewController") as? AdventureQRCodePuzzleViewController {
            // 어떤 도시인지 숫자를 알려주어야 함
            puzzle.puzzleCity = cityNumber
            self.navigationController?.pushViewController(puzzle, animated: true)
        }
    }
    
    
    @IBAction func openRightSideMenu(_ sender: UIButton) {
        super.showMenu {
            super.backgroundBlackAlpha(view: self.view)
            self.view.layoutIfNeeded()
        }
    }
    
}


extension AdventureQRCodeFlipViewController: UITextViewDelegate {

}
