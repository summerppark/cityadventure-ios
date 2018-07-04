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
    
    var landmarkNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        landmarkTableView.backgroundView?.addSubview(<#T##UIView#>)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func tappedBackbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
