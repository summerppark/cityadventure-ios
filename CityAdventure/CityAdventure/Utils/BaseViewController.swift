//
//  UIViewControllerExtensions.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 3..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let gifImage = UIImageView()
    
    // loading 중임을 표시.
    func showLoading(view: UIView) {
        gifImage.frame = CGRect(x: view.center.x - 64, y: view.center.y - 64, width: 128, height: 128)
        gifImage.image = UIImage.gif(name: "loading")
        view.addSubview(gifImage)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.gifImage.alpha = 1.0
        }
    }
    
    // 로딩을 숨김
    func hideLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.gifImage.alpha = 0.0
        }) { (finished: Bool) in
            self.gifImage.stopAnimating()
            self.gifImage.removeFromSuperview()
        }
    }
}
