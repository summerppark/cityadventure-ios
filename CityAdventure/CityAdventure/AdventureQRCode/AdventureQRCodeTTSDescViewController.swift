//
//  AdventureQRCodeTTSDescViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 15..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodeTTSDescViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 8.0
            mainView.layer.borderWidth = 8.0
            mainView.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var playerInfoView: UIView! {
        didSet {
            playerInfoView.layer.cornerRadius = 8.0
            playerInfoView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var playerSlider: UISlider! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.font = UIFont(name: "GodoM", size: 18.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        
//        let thumbImage = #imageLiteral(resourceName: "icon_sliderCircle")
//        let size = CGSize(width: thumbImage.size.width * 0.7, height: thumbImage.size.height * 0.7)
//        playerSlider.setThumbImage(self.imageWithImage(image: thumbImage, scaledToSize: size), for: .normal)
//        playerSlider.setThumbImage(self.imageWithImage(image: thumbImage, scaledToSize: size), for: .highlighted)
        

    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
   
    
}
