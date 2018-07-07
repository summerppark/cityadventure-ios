//
//  NewBaseResponse.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 7..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class NewBaseResponse: Mappable {
    var responseCode: String?
    var message: String?
    var dataLength: Int?
    var data: [String: Any]?
    
    required init?(map: Map) {
    }
    
     func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        dataLength <- map["dataLength"]
        data <- map["data"]
    }
    
}
