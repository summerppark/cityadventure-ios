//
//  AdventureQRCodeBoardPopUp.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 12..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeBoardPopUp: BaseViewController {
    
    @IBOutlet weak var totalNoteView: UIView! {
        didSet {
            totalNoteView.layer.cornerRadius = 8.0
            totalNoteView.backgroundColor = UIColor.yellow
            totalNoteView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = titleString
        }
    }
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
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
