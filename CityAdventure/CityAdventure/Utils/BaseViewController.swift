//
//  UIViewControllerExtensions.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 3..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import DCAnimationKit


class BaseViewController: UIViewController {
    
    var sideMenuViewController: RightSideMenuViewController!
    
    let gifImage = UIImageView()
    
    let bornArea = ["특광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"]
    
    var charImages = [#imageLiteral(resourceName: "img_thumbChar_first_On"),#imageLiteral(resourceName: "img_thumbChar_second_On"),#imageLiteral(resourceName: "img_thumbChar_third_On"),#imageLiteral(resourceName: "img_thumbChar_fourth_On"),#imageLiteral(resourceName: "img_thumbChar_fifth_On"),#imageLiteral(resourceName: "img_thumbChar_sixth_On")]
    var mainCharImages = [#imageLiteral(resourceName: "main1"),#imageLiteral(resourceName: "main2"),#imageLiteral(resourceName: "main3"),#imageLiteral(resourceName: "main4"),#imageLiteral(resourceName: "main5"),#imageLiteral(resourceName: "main6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "RightSideMenuViewController") as? RightSideMenuViewController {
            sideMenuViewController = menuVC
        }
    }
    
    func showMenu(handler: @escaping () -> Swift.Void) {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.addChildViewController(self.sideMenuViewController)
            self.view.addSubview(self.sideMenuViewController.view)
        }
    }
    
    
    func backgroundBlackAlpha(view: UIView) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    func closeMenu() {
        self.sideMenuViewController.view.removeFromSuperview()
    }
    
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


// LevelManager
extension BaseViewController {
    // Level
    func getLevel(exp: Int) -> Int {
        let a = 21
        let b = 21
        let c = -42-exp
        
        var d: Double = Double(b * b - 4 * a * c)
        var result: Double = 0
        if d == 0 {
            result = Double(+(-b/(2*a)))
        } else {
            result = (Double(-b) + d.squareRoot()) / Double(2*a)
        }
        
        let level = Int(result)
        return level
    }
    
    // 경험치 얻기
    func getExp(level: Int) -> Int {
        let exp = level * (level + 1) * 21 - 42
        return exp
    }
    
    
    // 다음레벨이 되기 위해 필요한 경험치를 준다.
    // 채워야하는 경험치
    func getNextNeedExpByLevel(level: Int) -> Int {
        let nowExp = getExp(level: level)
        let nextExp = getExp(level: level+1)
        return nextExp-nowExp
    }
    
    // 현재 얻은 경험치
    func getAbsExp(exp: Int) -> Int {
        let level = getLevel(exp: exp)
        let nowExp = getExp(level: level)
        return exp - nowExp
    }
    
    func convertDateFormatter(inputDate: String?) -> String {
        guard let inputDate = inputDate else {
            return ""
        }
        
        let dateString = inputDate.components(separatedBy: "-")
        let resultArray = ["년", "월", "일"]
        var result = ""
        
        for index in 0...dateString.count-1 {
            result = result + dateString[index] + resultArray[index]
            
            if index != dateString.count-1 {
                result = result + " "
            }
        }
        
        return result
    }
    
    
    func startAnimation(input: UIButton) {
        input.tada {
            input.tada {
                input.tada {
                    input.tada {
                        input.tada {
                            input.tada {
                                input.tada {
                                    input.tada {
                                        input.tada {
                                            input.tada {
                                                input.tada {
                                                    input.tada {
                                                        input.tada {
                                                            input.tada {
                                                                input.tada {
                                                                    input.tada {
                                                                        input.tada {
                                                                            input.tada {
                                                                                input.tada(nil)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
