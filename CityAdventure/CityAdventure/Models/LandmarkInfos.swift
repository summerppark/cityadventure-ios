//
//  LandmarkInfos.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 2..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class LandMarks: BaseResponse {
    var landMarkData: [String: Any] = [:]
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        landMarkData <- map["data"]
    }
    
    public class EmailData: Mappable {
        var no: Int?
        var s_name: String?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            s_name <- map["s_name"]
        }
    }
}

