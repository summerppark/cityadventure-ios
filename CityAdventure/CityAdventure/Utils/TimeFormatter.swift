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
    
    
    func getCurrentAge(date_birth: String) -> String {
        
        // 현재년도 2018
        let year = Calendar.current.component(.year, from: Date())
        // 앞글자 4자만짜른다 ex ) 1991
        
        let birth = Int(date_birth.prefix(4))
        var result = 0
        
        if let myBirth = birth {
           result = year - myBirth
        }

        return String(result)
    }
}
