//
//  AvatarManageMentViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class AvatarManageMentViewController: BaseViewController {
    // Data
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.layer.borderColor = UIColor.black.cgColor
            progressView.layer.borderWidth = 1.0
            progressView.layer.cornerRadius = 4.0
            progressView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userCharView: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var expMaxLabel: UILabel!
    @IBOutlet weak var expCurrentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myCardsCount: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    
    @IBOutlet weak var progressViewLeading: NSLayoutConstraint!
    @IBOutlet weak var userNameLabelTrailing: NSLayoutConstraint!

    ////
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    let charImageArray: [UIImage] = [#imageLiteral(resourceName: "img_char_first"),#imageLiteral(resourceName: "img_char_second"),#imageLiteral(resourceName: "img_char_third"),#imageLiteral(resourceName: "img_char_fourth"),#imageLiteral(resourceName: "img_char_fifth"),#imageLiteral(resourceName: "img_char_sixth")]
    let thumbCharSelected = [#imageLiteral(resourceName: "img_thumbChar_first_On"),#imageLiteral(resourceName: "img_thumbChar_second_On"),#imageLiteral(resourceName: "img_thumbChar_third_On"),#imageLiteral(resourceName: "img_thumbChar_fourth_On"),#imageLiteral(resourceName: "img_thumbChar_fifth_On"),#imageLiteral(resourceName: "img_thumbChar_sixth_On")]
    let thumbChar = [#imageLiteral(resourceName: "img_thumbChar_first"),#imageLiteral(resourceName: "img_thumbChar_second"),#imageLiteral(resourceName: "img_thumbChar_third"),#imageLiteral(resourceName: "img_thumbChar_fourth"),#imageLiteral(resourceName: "img_thumbChar_fifth"),#imageLiteral(resourceName: "img_thumbChar_sixth")]
    let avartarPrice: [Int] = [5000,5000,5000,5000,20000,20000]
    
    var myAvartar: [Int] = []
    var charCount: Int = 3
    var charIndex: Int = 0
    
    var thumbButtons: [UIButton] = []
    var thumbImages: [UIImageView] = []
    
    var categoryScrollView = UIScrollView()
    
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            mainScrollView.backgroundColor = .clear
            mainScrollView.clipsToBounds = true
            mainScrollView.isPagingEnabled = true
            mainScrollView.delegate = self
            mainScrollView.showsHorizontalScrollIndicator = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetting()
        layoutCheck()
        mainScrollView.contentSize = CGSize(width: Double(self.view.frame.width) * Double(6.0), height: 320.0)
        
        if let myavar = DataManager.shared.userInfo?.userInfo?.s_listOfAvatarNo {
            myavar.forEach({ (avar) in
                myAvartar.append(avar-1)
            })
        }

        makeThumbScroll()
        setCurrentChar()
        charViewLayout(index: 5)
    }
    
    func setCurrentChar() {
        if let info = DataManager.shared.userInfo?.userInfo?.ui_avatarNo {
            self.thumbButtons[info-1].setImage(thumbCharSelected[info-1], for: .normal)
            selecedControlSync(index: info-1)
        }
    }
    
    func makeThumbScroll() {
        categoryScrollView.tag = 100
        categoryScrollView.backgroundColor = .clear
        self.view.addSubview(categoryScrollView)
        
        categoryScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollView.snp.bottom).offset(16.0)
            make.centerX.equalTo(self.view.snp.centerX)
            
            make.leading.trailing.equalTo(self.view)
            make.height.equalTo(80)
        }
        
        categoryScrollView.clipsToBounds = true
        categoryScrollView.isPagingEnabled = true
        categoryScrollView.delegate = self
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryScrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: 80.0)
        
        let firstpage = UIView()
        let secondpage = UIView()
        if Constants.DeviceType.IS_IPHONE_6P {
            firstpage.frame = CGRect(x: 40, y: 0, width: self.view.frame.width - 80, height: 80)
            //                    firstpage.backgroundColor = .red
            categoryScrollView.addSubview(firstpage)
            secondpage.frame = CGRect(x: self.view.frame.width + 40, y: 0, width: self.view.frame.width - 40, height: 80)
            //                    secondpage.backgroundColor = .blue
            categoryScrollView.addSubview(secondpage)
        } else {
            firstpage.frame = CGRect(x: 20, y: 0, width: self.view.frame.width - 40, height: 80)
            //                    firstpage.backgroundColor = .red
            categoryScrollView.addSubview(firstpage)
            
            secondpage.frame = CGRect(x: self.view.frame.width + 20, y: 0, width: self.view.frame.width - 40, height: 80)
            //                    secondpage.backgroundColor = .blue
            categoryScrollView.addSubview(secondpage)
        }
        
        
        for index in 0...3 {
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            button.setImage(thumbChar[index], for: .normal)
            button.frame = CGRect(x: 80.0 * Double(index) + Double(index) * 8, y: 0, width: 80.0, height: 80.0)
            
            
            
            let isMyAvatar = UIImageView()
            isMyAvatar.tag = index
            isMyAvatar.backgroundColor = .clear
            isMyAvatar.frame = CGRect(x: 80.0 * Double(index) + Double(index) * 8 + 56.0, y: 0, width: 20, height: 28)
            isMyAvatar.isHidden = true
            thumbButtons.append(button)
            thumbImages.append(isMyAvatar)
            firstpage.addSubview(button)
            firstpage.addSubview(isMyAvatar)
        }
        
        for index in 4...5 {
            let newindex = index - 4
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            button.setImage(thumbChar[index], for: .normal)
            button.frame = CGRect(x: 80.0 * Double(newindex) + Double(newindex) * 8, y: 0, width: 80.0, height: 80.0)
            
            let isMyAvatar = UIImageView()
            isMyAvatar.tag = index
            isMyAvatar.backgroundColor = .clear
            isMyAvatar.isHidden = true
            isMyAvatar.frame = CGRect(x: 80.0 * Double(newindex) + Double(newindex) * 8 + 56.0, y: 0, width: 20, height: 28)
            
            
            thumbButtons.append(button)
            thumbImages.append(isMyAvatar)
            secondpage.addSubview(button)
            secondpage.addSubview(isMyAvatar)
        }
        
        myAvartar.forEach { (index) in
            thumbImages[index].isHidden = false
        }
        
    }
    
    @objc func selectChar(sender: UIButton) {
        selecedControlSync(index: sender.tag)
    }
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P {
            progressViewLeading.constant = 12
            userNameLabelTrailing.constant = 24
        }
        
        if Constants.DeviceType.IS_IPHONE_X {
            bottomConst.constant = 48.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSetting()
        layoutCheck()
    }
    
    // 캐릭터 선택 뷰
    func charViewLayout(index: Int) {
        
        for index in 0...index {
            let view = UIView(frame: CGRect(x: self.view.frame.width * CGFloat(index), y: 0, width: self.view.frame.width, height: 320))
            view.backgroundColor = .clear
            
            
            let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: view.frame.width-40, height: view.frame.height))
            imageView.image = UIImage(named:"img_char_bg")
            view.addSubview(imageView)
            
            
            var charImageSize = CGRect()
            var originY = 0.0
            switch index {
            case 0:
                charImageSize = CGRect(x: 80, y: 8, width: 210, height: 232)
                originY = 232.0
            case 1:
                charImageSize = CGRect(x: 80, y: 8, width: 230, height: 232)
                originY = 232.0
            case 2:
                charImageSize = CGRect(x: 86, y: 24, width: 208, height: 190)
                originY = 190.0
            case 3:
                charImageSize = CGRect(x: 80, y: 80, width: 230, height: 116)
                originY = 116.0
            case 4:
                charImageSize = CGRect(x: 80, y: 8, width: 210, height: 232)
            case 5:
                charImageSize = CGRect(x: 80, y: 8, width: 210, height: 232)
            default:
                
                print("No  !   Case")
            }
            
           
            let charImageView = UIImageView(frame: charImageSize)
            
            charImageView.image = charImageArray[index]
            view.addSubview(charImageView)
            
            let coinView = UIView(frame: CGRect(x: 100.0, y: 320.0-48.0, width: 80.0, height: 30.0))
            
            coinView.backgroundColor = .yellow
            coinView.layer.cornerRadius = 8.0
            coinView.clipsToBounds = true
            
            view.addSubview(coinView)
            
            let coinImage = UIImageView(frame: CGRect(x: 8.0, y: 5.0, width: 20.0, height: 20.0))
            
            coinImage.image = #imageLiteral(resourceName: "img_coin")
            coinView.addSubview(coinImage)
            
            
            let price = UILabel(frame: CGRect(x: 33.0, y: 5.0, width: 40.0, height: 20.0))
            price.font = UIFont.init(name: "GodoM", size: 10.0)
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            price.text = nf.string(from: NSNumber(integerLiteral: avartarPrice[index]))
            coinView.addSubview(price)

            let selectButton = UIButton(frame: CGRect(x: 210.0, y: 320.0-48.0, width: 80.0, height: 30.0))
            selectButton.tag = index
             selectButton.addTarget(self, action: #selector(tappedPurchase), for: .touchUpInside)
            selectButton.setBackgroundImage(#imageLiteral(resourceName: "3_17"), for: .normal)
            
            selectButton.titleLabel?.font = UIFont.init(name: "GodoM", size: 14.0)
            selectButton.setTitleColor(.black, for: .normal)
            view.addSubview(selectButton)
            
            
            if self.myAvartar.contains(index) {
                let mine = UIImageView(frame: CGRect(x: 220.0, y: 320.0-48.0-16.0-90.0, width: 80.0, height: 80.0))
                    mine.image = #imageLiteral(resourceName: "img_isMyAvatar")
                    view.addSubview(mine)
                selectButton.setTitle("선택하기", for: .normal)
            } else {
                selectButton.setTitle("구매하기", for: .normal)
            }
            
            
            
            self.mainScrollView.addSubview(view)
        }
    }
    
    @objc func tappedPurchase(sender: UIButton) {
        print(sender.tag)
        // 내가 갖고있는 아바타 리스트에 포함되있다면 변경하는 로직
        // 없다면 구매하는 로직
        
        
        
    }
    
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
    @IBAction func showRightMenu(sender: UIButton) {
        super.showMenu {
            super.backgroundBlackAlpha(view: self.view)
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func leftBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension AvatarManageMentViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.tag != 100 {
            NSObject.cancelPreviousPerformRequests(withTarget: scrollView)
            self.perform(#selector(self.scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0)
        }
        
    }
    
    // Page에 따른 버튼 상태
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        if scrollView.tag != 100 {
            let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            print(pageNumber)
            selectedStatus(index: pageNumber)
            selecedControlSync(index: pageNumber)
        }
        
    }
    
    // 선택된 캐릭터만 하이라이트
    func selectedStatus(index: Int) {
        charIndex = index
        if index > 3 {
            let page = CGPoint(x: self.view.frame.width, y: 0.0)
            categoryScrollView.setContentOffset(page, animated: true)
        } else {
            let page = CGPoint(x: 0.0, y: 0.0)
            categoryScrollView.setContentOffset(page, animated: true)
        }
        
    }
    
    
    @IBAction func tappedSideButton(_ sender: UIButton) {
        if sender.tag == 0 && charIndex != 0 {
            charIndex -= 1
            selecedControlSync(index: charIndex)
        } else if sender.tag == 1 && charIndex != 5 {
            charIndex += 1
            selecedControlSync(index: charIndex)
        } else {
            print("NoCase")
        }
    }
    
    
    func selecedControlSync(index: Int) {
        selectedStatus(index: index)
        
        if Constants.DeviceType.IS_IPHONE_6P {
            let pageIndex = CGPoint(x: 414.0 * Double(index), y: 0)
            mainScrollView.setContentOffset(pageIndex, animated: true)
        } else {
            let pageIndex = CGPoint(x: Double(mainScrollView.frame.size.width) * Double(index), y: 0)
            mainScrollView.setContentOffset(pageIndex, animated: true)
        }
        
        if index > 3 {
            let page = CGPoint(x: self.view.frame.width, y: 0.0)
            categoryScrollView.setContentOffset(page, animated: true)
        } else {
            let page = CGPoint(x: 0.0, y: 0.0)
            categoryScrollView.setContentOffset(page, animated: true)
        }
        
        thumbImages.forEach { (img) in
            img.image = #imageLiteral(resourceName: "myAvatar_off")
        }
        
        thumbImages[index].image = #imageLiteral(resourceName: "myAvatar_on")
        
        
        
        for newIndex in 0...thumbChar.count-1 {
            thumbButtons[newIndex].setImage(thumbChar[newIndex], for: .normal)
        }
        
        thumbButtons[index].setImage(thumbCharSelected[index], for: .normal)
        
    }
}
