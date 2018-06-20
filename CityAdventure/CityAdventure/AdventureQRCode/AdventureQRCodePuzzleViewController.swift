//
//  AdventureQRCodePuzzleViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 15..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class AdventureQRCodePuzzleViewController: BaseViewController {

    @IBOutlet var topImageViews: [UIImageView]!
    @IBOutlet var randomImageCard: [UIImageView]!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var imagesArray: [UIImage] = []
    var initialCenter = CGPoint()
    
    var collectCardCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
  
        super.showLoading(view: self.view)
        var img = #imageLiteral(resourceName: "adventure_Exercise_bg")
        let img2 = img
        
        DispatchQueue.global().async {
            img = self.Noir(image: img)
            DispatchQueue.main.async {
                super.hideLoading()
                self.makeRandomCard(image: img2)
                let top = img.topHalf
                let mid = img.middleHalf
                let bottom = img.bottomHalf
                
                
                self.topImageViews[0].image = top?.leftHalf
                self.topImageViews[1].image = top?.centerHalf
                self.topImageViews[2].image = top?.rightHalf
                
                self.topImageViews[3].image = mid?.leftHalf
                self.topImageViews[4].image = mid?.centerHalf
                self.topImageViews[5].image = mid?.rightHalf
                
                self.topImageViews[6].image = bottom?.leftHalf
                self.topImageViews[7].image = bottom?.centerHalf
                self.topImageViews[8].image = bottom?.rightHalf
                
                var count = 0
                let pangesture = UIPanGestureRecognizer(target: self, action: #selector(self.isCollect))
                self.topImageViews.forEach { (img) in
                    img.tag = count
                    img.layer.borderWidth = 1
                    img.layer.borderColor = UIColor.black.cgColor
                    count = count + 1
                    img.isUserInteractionEnabled = true
                    img.addGestureRecognizer(pangesture)
                }
                
                
                self.randomImageCard.forEach({ (img) in
                    img.isUserInteractionEnabled = true
                    img.layer.borderWidth = 1
                    img.layer.borderColor = UIColor.black.cgColor
                    let pangesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleCard))
                    pangesture.minimumNumberOfTouches = 1
                    img.addGestureRecognizer(pangesture)
                })
            }
        }
    }
    
    @objc func isCollect(sender: UIPanGestureRecognizer) {
        
    }
    
    @objc func handleCard(sender: UIPanGestureRecognizer) {
        
        let piece = sender.view!
        let initPoint = piece.center
        let translation = sender.translation(in: piece.superview)
        
        let anaswerImage = topImageViews[(sender.view?.tag)!]
        if sender.state == .began {
            self.initialCenter = piece.center
        }
        if sender.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        }
        
        if sender.state == .ended {
            print("ended",piece.center,initPoint,topImageViews[(sender.view?.tag)!].center)
            // 정답 위치로
            
            if abs((anaswerImage.center.x+anaswerImage.center.y)-(piece.center.x+piece.center.y)) < 24 {
                topImageViews[(sender.view?.tag)!].image = (sender.view as? UIImageView)?.image
                sender.view?.isHidden = true
                // 정답인 경우!!!!
                collectCardCount += 1
                if collectCardCount == 9 {
                    print("모두 획득하였습니다.")
                    
                    if let popup = storyboard?.instantiateViewController(withIdentifier: "CollectCityPopupViewController") as? CollectCityPopupViewController {
                        popup.modalPresentationStyle = .overFullScreen
                        self.present(popup, animated: false, completion: nil)
                    }
                    
                }
                
            } else {
                // 원래자리로 , 실패
                piece.center = self.initialCenter
            }
            
            
        }
    }
    
    
    // random 으로 카드를 배열
    func makeRandomCard(image: UIImage) {
        var randomArray : [Int] = [0,1,2,3,4,5,6,7,8]
        randomArray.shuffle()
        print("random",randomArray)
        let puzzleArray = [image.topHalf?.leftHalf,
                           image.topHalf?.centerHalf,
                           image.topHalf?.rightHalf,
                           image.middleHalf?.leftHalf,
                           image.middleHalf?.centerHalf,
                           image.middleHalf?.rightHalf,
                           image.bottomHalf?.leftHalf,
                           image.bottomHalf?.centerHalf,
                           image.bottomHalf?.rightHalf]
        
        for index in 0...randomArray.count-1 {
            randomImageCard[randomArray[index]].image = puzzleArray[index]
            randomImageCard[randomArray[index]].tag = index
        }
    }
    
    @IBOutlet weak var topView: UIView! {
        didSet{
            topView.layer.borderColor = UIColor.black.cgColor
            topView.layer.borderWidth = 8.0
        }
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    
    func Noir(image: UIImage) -> UIImage {
        var context = CIContext(options: nil)
        
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
    
}

extension UIImage {
    var topHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height/3))) else { return nil }
        return UIImage(cgImage: image, scale: 1, orientation: imageOrientation)
    }
    
    var middleHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(x: 0, y: self.size.height/3, width: size.width, height: size.height/3)) else { return nil }
        
        print("middle", image)
        return UIImage(cgImage: image)
    }

    var bottomHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(x: 0, y: self.size.height/3*2, width: size.width, height: size.height/3)) else { return nil }
        
        print("bottom", image)
        return UIImage(cgImage: image)
    }
    
    
    var leftHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: .zero, size: CGSize(width: size.width/3, height: size.height))) else { return nil }
        return UIImage(cgImage: image)
    }
    
    var centerHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(x: size.width/3, y: 0, width: size.width/3, height: size.height)) else { return nil }
        
        return UIImage(cgImage: image)
    }
    
    
    var rightHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(x: size.width/3*2, y: 0, width: size.width/3, height: size.height)) else { return nil }
        
        return UIImage(cgImage: image)
    }
}


extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
