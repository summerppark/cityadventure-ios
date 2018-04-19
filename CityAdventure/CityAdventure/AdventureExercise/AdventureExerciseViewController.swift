//
//  AdventureExerciseViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 19..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureExerciseViewController: BaseViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cardCountView: UIView! {
        didSet {
            cardCountView.layer.cornerRadius = 16.0
            cardCountView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var cardCount: String?
    
    @IBOutlet weak var getCardsStatus: UILabel! {
        didSet {
            print(cardCount)
            getCardsStatus.text = "\(cardCount!) / 162"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension AdventureExerciseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 162
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCollectionViewCell", for: indexPath) as! ExerciseCollectionViewCell
       cell.stageLabel.text = "\(indexPath.item + 1)"
        if indexPath.item == 0 {
            cell.stageView.layer.borderColor = UIColor.red.cgColor
            cell.stageView.backgroundColor = UIColor.lightBrownBgColor
            cell.stageLabel.textColor = .black
        }
        
        return cell
    }
    
    // Button ( CELL ) Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 4.0 - 4.0 * 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item, "GGG")
    }
}
