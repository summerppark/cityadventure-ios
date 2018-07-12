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
    
    
    // red EB5767
    // orange F1A241
    // yellow F6D24A
    // lightBlue 92C9E1
    // blue 4C9CD6
    // green D4DC47
    // darkGreen 89C2A5
    // pink E1B0C9
    // purple AB9AC5
    // brown 956531
    
    func cityTypeColor(province: Int) -> UIColor {
        switch province {
        case 0:
            //red
            return UIColor().colorFromHex("EB5767")
        case 1:
            //orange
            return UIColor().colorFromHex("F1A241")
        case 2:
            //yellow
            return UIColor().colorFromHex("F6D24A")
        case 3:
            //lightBlue
            return UIColor().colorFromHex("92C9E1")
        case 4:
            //blue
            return UIColor().colorFromHex("4C9CD6")
        case 5:
            //green
            return UIColor().colorFromHex("D4DC47")
        case 6:
            //darkGreen
            return UIColor().colorFromHex("89C2A5")
        case 7:
            //pink
            return UIColor().colorFromHex("E1B0C9")
        case 8:
            //purple
            return UIColor().colorFromHex("AB9AC5")
        case 9:
            //brown
            return UIColor().colorFromHex("956531")
        default:
            //default Orange
            return UIColor().colorFromHex("F1A241")
        }
    }
    
    
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
