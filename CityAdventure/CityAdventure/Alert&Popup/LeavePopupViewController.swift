//
//  LeavePopupViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 7..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

protocol LeavePopupProtocol {
    func dismissAfter()
}

class LeavePopupViewController: BaseViewController {
    
    @IBOutlet weak var leaveLabel: UILabel!
    
    @IBOutlet weak var content1: UILabel!
    @IBOutlet weak var content2: UILabel!
    
    var titleString: String?
    var contentString1: String?
    var contentString2: String?
    
    var delegate: LeavePopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        print(titleString, contentString1, contentString2)
        leaveLabel.text = titleString
        content1.text = contentString1
        content2.text = contentString2
        
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false) {
            if self.titleString == nil {
                let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navigationController = UINavigationController(rootViewController: login)
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = navigationController
            } else {
                self.delegate?.dismissAfter()
            }
        }
    }
}
