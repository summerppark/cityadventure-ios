//
//  ColorExtensions.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 25..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

extension UIColor {
    static let top_Brown_Color = UIColor().colorFromHex("#59493f")
    static let textView_gray_Color = UIColor().colorFromHex("#858583")
    static let status_ok_Color = UIColor().colorFromHex("#15b2d4")
    static let status_no_Color = UIColor().colorFromHex("#f90404")
    static let placeHolderColor = UIColor().colorFromHex("#b4b3b3")
    static let buttonTitleColor = UIColor().colorFromHex("#B4B3B3")
    static let lightBrownBgColor = UIColor().colorFromHex("#e0dbc8")
    static let ultraLightGray = UIColor().colorFromHex("#dcdcdc")
    static let strokeGreenColor = UIColor().colorFromHex("#45a482")
    static let placeholderColor = UIColor().colorFromHex("#C7C7CD")
    static let insideRedColor = UIColor().colorFromHex("#f35a5a")
    
    func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return .black
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
    }
}
