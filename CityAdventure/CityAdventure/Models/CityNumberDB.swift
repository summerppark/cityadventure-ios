//
//  CityNumberDB.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 30..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

struct CityNumbersDB {
    let number: Int64
    let cityName: String
    let cityType: String
    let provinceType: Int64
    let areaName: String
    
    init(number: Int64, cityName: String, cityType: String, provinceType: Int64, areaName: String) {
        self.number = number
        self.cityName = cityName
        self.cityType = cityType
        self.provinceType = provinceType
        self.areaName = areaName
    }
}
