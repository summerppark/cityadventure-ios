//
//  LandMarkDetailViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 4..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class LandMarkDetailViewController: BaseViewController {

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var landmarkTableView: UITableView!
    
    
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkDesc: UITextView! {
        didSet {
            landmarkDesc.font = UIFont.init(name: "GodoM", size: 16.0)
        }
    }
    
    @IBOutlet weak var photoSliderView: UIScrollView!
    
    var landmarkNumber: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutcheck()
        print("landmarkNumber", landmarkNumber)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func layoutcheck() {
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88.0
        }
    }
    

    
    @IBAction func tappedBackbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
