//
//  LandmarkDetail.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class LandmarkDetail: BaseResponse {
    
    var detailData: DetailData?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        detailData <- map["data"]
    }
    
    public class DetailData: Mappable {
        var no: Int?
        var ui_city: Int?
        var s_name: String?
        var t_description: String?
        var date_registered: String?
        var date_updated: String?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            ui_city <- map["ui_city"]
            s_name <- map["s_name"]
            t_description <- map["t_description"]
            date_registered <- map["date_registered"]
            date_updated <- map["date_updated"]
        }
        
    }
}
