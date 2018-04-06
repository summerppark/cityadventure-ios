//
//  TimeFormatter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation


struct TimeFormatter {
    func getCurrentTime() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return Int(dateFormatter.string(from: Date()))
    }
}
