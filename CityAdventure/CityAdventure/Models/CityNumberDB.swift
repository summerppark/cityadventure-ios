//
//  CityNumberDB.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 30..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

struct CityNumbersDB {
    let number: Int32
    let cityName: String
    let cityType: String
    let provinceType: Int32
    let areaName: String
    let hint: String
    
    init(number: Int32, cityName: String, cityType: String, provinceType: Int32, areaName: String, hint: String) {
        self.number = number
        self.cityName = cityName
        self.cityType = cityType
        self.provinceType = provinceType
        self.areaName = areaName
        self.hint = hint
    }
}
