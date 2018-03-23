//
//  LaunchScreenViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 23..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SwiftGifOrigin


class LaunchScreenViewController: UIViewController {
    
    // gif
    @IBOutlet weak var loadGifImage: UIImageView! {
        didSet {
            let gifFile = UIImage.gif(name: "loading")
            loadGifImage.image = gifFile
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navi hidden
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            print("3초 후")
            // 로그인 화면으로 옵셔널 체크 후 전환
            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        })
    }
    
    
}
