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
    
    @IBOutlet weak var selectCitysView: UIView! {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


extension MyCollectCityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("DataManager.shared.citynumbers.count",  DataManager.shared.citynumbers.count)
        return 162
        
        
        
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
