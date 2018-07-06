//
//  CharacterChoiceViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 30..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

class CharacterChoiceViewController: UIViewController {
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.backgroundColor = .clear
            scrollView.clipsToBounds = true
            scrollView.isPagingEnabled = true
            scrollView.delegate = self
            scrollView.showsHorizontalScrollIndicator = true
        }
    }
    
    var charCount: Int = 3
    var charIndex: Int = 0
    
    let charImageArray: [UIImage] = [#imageLiteral(resourceName: "img_char_first"),#imageLiteral(resourceName: "img_char_second"),#imageLiteral(resourceName: "img_char_third"),#imageLiteral(resourceName: "img_char_fourth")]
    let thumbCharSelected = [#imageLiteral(resourceName: "img_thumbChar_first_On"),#imageLiteral(resourceName: "img_thumbChar_second_On"),#imageLiteral(resourceName: "img_thumbChar_third_On"),#imageLiteral(resourceName: "img_thumbChar_fourth_On")]
    let thumbChar = [#imageLiteral(resourceName: "img_thumbChar_first"),#imageLiteral(resourceName: "img_thumbChar_second"),#imageLiteral(resourceName: "img_thumbChar_third"),#imageLiteral(resourceName: "img_thumbChar_fourth")]
    @IBOutlet var thumbCharButtons: [UIButton]!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(charCount+1), height: 320)
        charViewLayout(index: charCount)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.set(String(charIndex), forKey: "signup_char")
    }
    
    
    // 캐릭터 선택 뷰
    func charViewLayout(index: Int) {
        
        for index in 0...index {
            let view = UIView(frame: CGRect(x: self.view.frame.width * CGFloat(index), y: 0, width: self.view.frame.width, height: 320))
            view.backgroundColor = .clear

            
            let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: view.frame.width-40, height: view.frame.height))
            imageView.image = UIImage(named:"img_char_bg")
            view.addSubview(imageView)
            
            let noticeView = UIImageView(frame: CGRect(x: 40, y: view.frame.height-60, width: view.frame.width-80, height: 40))
            noticeView.image = UIImage(named: "img_notice_char")
            view.addSubview(noticeView)
            var charImageSize = CGRect()
            switch index {
            case 0:
                 charImageSize = CGRect(x: 80, y: 8, width: 210, height: 232)
            case 1:
                charImageSize = CGRect(x: 80, y: 8, width: 230, height: 232)
            case 2:
                charImageSize = CGRect(x: 86, y: 24, width: 208, height: 190)
            case 3:
                charImageSize = CGRect(x: 80, y: 80, width: 230, height: 116)
            default:
                print("No  !   Case")
            }
            let charImageView = UIImageView(frame: charImageSize)
            charImageView.image = charImageArray[index]
            view.addSubview(charImageView)
            self.scrollView.addSubview(view)
        }
    }
    
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
        }
    }
    
    
    @IBAction func charChoice(_ sender: UIButton) {
        charIndex = sender.tag
        selecedControlSync(index: sender.tag)
    }
    
    @IBAction func tappedSideButton(_ sender: UIButton) {
        if sender.tag == 0 && charIndex != 0 {
            charIndex -= 1
            selecedControlSync(index: charIndex)
        } else if sender.tag == 1 && charIndex != 3 {
            charIndex += 1
            selecedControlSync(index: charIndex)
        } else {
            print("NoCase")
        }
    }
    
    @IBAction func goToNext(_ sender: Any) {
        if let final = storyboard?.instantiateViewController(withIdentifier: "SignUpViewFinalController") as? SignUpViewFinalController {
            final.charIndex = charIndex
            self.navigationController?.pushViewController(final, animated: true)
        }
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CharacterChoiceViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NSObject.cancelPreviousPerformRequests(withTarget: scrollView)
//        self.perform(#selector(self.scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NSObject.cancelPreviousPerformRequests(withTarget: scrollView)
        self.perform(#selector(self.scrollViewDidEndScrollingAnimation(_:)), with: scrollView, afterDelay: 0)
    }
    
    // Page에 따른 버튼 상태
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        print(pageNumber)
        selectedStatus(index: pageNumber)
    }
    
    // 선택된 캐릭터만 하이라이트
    func selectedStatus(index: Int) {
        charIndex = index
        for index in 0...thumbCharButtons.count-1 {
            thumbCharButtons[index].setImage(thumbChar[index], for: .normal)
        }
        thumbCharButtons[index].setImage(thumbCharSelected[index], for: .normal)
    }
    
    func selecedControlSync(index: Int) {
        selectedStatus(index: index)
        let pageIndex = CGPoint(x: Double(scrollView.frame.size.width) * Double(index), y: 0)
        scrollView.setContentOffset(pageIndex, animated: true)
    }
}

