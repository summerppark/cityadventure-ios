//
//  AdventureQRCodeBoardPopUp.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 12..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Alamofire
import Toaster

class AdventureQRCodeBoardPopUp: BaseViewController {
    
    @IBOutlet weak var totalNoteView: UIView! {
        didSet {
            totalNoteView.layer.cornerRadius = 8.0
            totalNoteView.backgroundColor = UIColor.yellow
            totalNoteView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.text = subTitleString
        }
    }
    
    @IBOutlet weak var femaleCount: UILabel! {
        didSet {
            femaleCount.text = "\(fmCount ?? 0)만명"
        }
    }
    @IBOutlet weak var maleCount: UILabel! {
        didSet {
            maleCount.text = "\(mCount ?? 0)만명"
        }
    }
    
    
    @IBOutlet weak var totalCount: UILabel! {
        didSet {
//            totalCount.text = "\(fmCount!+mCount!)만명"
        }
    }
    
    
    var cityNumber: String = ""
    var cityName: String = ""
    
    
    var fmCount: Int?
    var mCount: Int?
    
    
    var titleString: String?
    var subTitleString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        titleString = "부산의 면적은 1000㎢ 입니다."
        subTitleString = "님자: 9,000,000명, 여자: 2,000,000명\n 부산의 인구는 약 1100만명"
        fmCount = 200
        mCount = 900
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        super.showLoading(view: self.view)
        
        

        Alamofire.request(APIUrls.getCityStatistics(index: cityNumber), method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.result.value as? NSDictionary, let responseData = data["data"] as? NSDictionary {
                if let area = responseData["ud_area"] as? String,
                    let male = responseData["ui_femalePop"] as? Int,
                    let female = responseData["ui_malePop"] as? Int {
                    self.updateCityInfo(name: self.cityName, male: male, female: female, area: area)
                } else {
                    Toast(text: "에러가 발생했습니다. 다시 시도해주세요").show()
                }
                
            } else {
                Toast(text: "에러가 발생했습니다. 다시 시도해주세요").show()
            }
            super.hideLoading()
        }
        
    }
    
    
    
    
    
    
    func updateCityInfo(name: String, male: Int, female: Int, area: String) {
        
    
        let total = ((Float(male+female))/10000.0)
        // Title
        self.titleLabel.text = "\(name)의 면적은 \(area)㎢ 입니다."
//        subTitleString = "님자: 9,000,000명, 여자: 2,000,000명\n 부산의 인구는 약 1100만명"
        self.subTitleLabel.text = "남자: \(male)명, 여자: \(female)명\n \(name)의 인구는 약 \(Int(total.rounded()))만명"
        
        self.maleCount.text = "약\(Int((Float(male)/10000.0).rounded()))만명"
        self.femaleCount.text = "약\(Int((Float(female)/10000.0).rounded()))만명"
        self.totalCount.text = "약\(Int(total.rounded()))만명"
        
        
        
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
