//
//  MyCollectCityViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 29..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class MyCollectCityViewController: BaseViewController {
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var selectCitysView: HADropDown! {
        didSet {
            selectCitysView.layer.cornerRadius = 8.0
            selectCitysView.clipsToBounds = true
            selectCitysView.layer.borderWidth = 3.0
            selectCitysView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var cityCountView: UIView! {
        didSet {
            cityCountView.layer.cornerRadius = 8.0
            cityCountView.clipsToBounds = true
            cityCountView.layer.borderWidth = 3.0
            cityCountView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var cityCount: UILabel!
    
    var cityArray: [CityNumbersDB] = []
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCitysView.items = ["전체보기", "특광역시","경기도", "강원도","충청북도", "충청남도","전라북도", "전라남도", "경상북도", "경상남도", "제주도"]
        
        selectCitysView.delegate = self
        
        
        cityArray = DataManager.shared.citynumbers
        cityCollectionView.reloadData()

        dataSetting()
        layoutCheck()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSetting()
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
            myCoin.text = "\(coin)"
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
    
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P {
            progressViewLeading.constant = 12
            userNameLabelTrailing.constant = 24
        }
    }
    
    func getCities(group: Int) {
        
        self.cityArray.removeAll()
        
        guard group != -1 else {
            self.cityArray = DataManager.shared.citynumbers
            cityCount.text = "\(cityArray.count) / 162"
            cityCollectionView.reloadData()
            return
        }
        
        DataManager.shared.citynumbers.forEach { (city) in
            if city.provinceType == Int32(group) {
                self.cityArray.append(city)
                cityCount.text = "0 / \(cityArray.count)"
            }
        }
        cityCollectionView.reloadData()
    }
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        super.showMenu {
            super.backgroundBlackAlpha(view: self.view)
            self.view.layoutIfNeeded()
        }
    }
    
}


extension MyCollectCityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("DataManager.shared.citynumbers.count",  DataManager.shared.citynumbers.count)
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectCityCell", for: indexPath) as! MyCollectCityCell
        return cell
    }
    
    // Button ( CELL ) Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 4.0
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }
}


extension MyCollectCityViewController: HADropDownDelegate {
    func didSelectItem(dropDown: HADropDown, at index: Int) {
        print("Item selected at index \(index)")
        getCities(group: index-1)
    }
}
