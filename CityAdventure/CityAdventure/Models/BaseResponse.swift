//
//  BaseResponse.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 3..
//  Copyright © 2018년 bubu. All rights reserved.
//

import ObjectMapper

class BaseResponse: Mappable {
   
    var responseCode: String?
    var message: String?
    var dataLength: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        dataLength <- map["dataLength"]
    }
}
