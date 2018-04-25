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
    
    @IBOutlet weak var getCardsStatus: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면 뜰 때마다 로컬에 저장된 데이터를 가져온다.
        if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
             DataManager.adventureExercise = UserDefaults.standard.integer(forKey: "\(name)_exerciseStage")
        }
        print(DataManager.adventureExercise)
        
        getCardsStatus.text = "\(DataManager.adventureExercise) / 162"
        collectionView.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let name = DataManager.shared.getUserInfo()?.userInfo?.s_name {
            // 스테이지 상태를 로컬에 저장한다.
            UserDefaults.standard.set(DataManager.adventureExercise, forKey: "\(name)_exerciseStage")
            print("저장 키워드 == \(name)_exerciseStage")
        }
        
        
        
    }
    
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    func stageSetting(label: UILabel, view: UIView, type: Int) {
        // type = 1 이면 현재 깨야되는 판 -> 레드
        if type == 1 {
            view.layer.borderColor = UIColor.red.cgColor
            view.backgroundColor = UIColor.insideRedColor
            label.textColor = .white
        } else if type == 2{
            view.layer.borderColor = UIColor().colorFromHex("#c4c4c4").cgColor
            view.backgroundColor = UIColor.clear.withAlphaComponent(0.1)
            label.textColor = .black
        } else {
            view.layer.borderColor = UIColor.placeHolderColor.cgColor
            view.backgroundColor = UIColor().colorFromHex("#797979")
            label.textColor = .white
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
       
        if indexPath.item + 1 <= DataManager.adventureExercise {
            self.stageSetting(label: cell.stageLabel, view: cell.stageView, type: 2)
        } else if indexPath.item == DataManager.adventureExercise {
            self.stageSetting(label: cell.stageLabel, view: cell.stageView, type: 1)
        } else {
            //기본 스토리보드에 셋팅한 값.
            self.stageSetting(label: cell.stageLabel, view: cell.stageView, type: 0)
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
        if indexPath.item + 1 <= DataManager.adventureExercise || indexPath.item == DataManager.adventureExercise
        {
            if let game = storyboard?.instantiateViewController(withIdentifier: "ExerciseGameViewController") as? ExerciseGameViewController {
                game.stageNumber = indexPath.item
                self.navigationController?.pushViewController(game, animated: true)
            }
        }
    }
}
