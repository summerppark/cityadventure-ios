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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCitysView.items = ["전체보기", "특광역시","경기도", "강원도","충청북도", "충청남도","전라북도", "전라남도", "경상북도", "경상남도", "제주도"]
        
        selectCitysView.delegate = self
        
        
        cityArray = DataManager.shared.citynumbers
        cityCollectionView.reloadData()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
