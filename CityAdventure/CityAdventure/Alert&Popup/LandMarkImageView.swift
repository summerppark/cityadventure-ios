//
//  LandMarkImageView.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 12..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class LandmarkImageView: BaseViewController {
    
    var lmImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = lmImage
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared
    }
    
    func addGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(down))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
    }
    
    @objc func down() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func close(sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
