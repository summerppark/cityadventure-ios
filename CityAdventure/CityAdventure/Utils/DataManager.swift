//
//  DataManager.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 30..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import GRDB



class DataManager {
    // 고향,사는곳 선택하는 DB
    var citynumbers: [CityNumbersDB] = []
    static let shared: DataManager = DataManager()
    
}
