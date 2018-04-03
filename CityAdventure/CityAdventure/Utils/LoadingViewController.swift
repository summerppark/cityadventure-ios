//
//  LoadingViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 3..
//  Copyright © 2018년 bubu. All rights reserved.
//

import SwiftGifOrigin
import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingGifView: UIImageView! {
        didSet {
            let gifFile = UIImage.gif(name: "loading")
            loadingGifView.image = gifFile
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 사라질 때 멈춤
        loadingGifView.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
