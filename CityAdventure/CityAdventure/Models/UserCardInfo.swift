//
//  UserCardInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class UserCardInfo: BaseResponse {
    var cardInfo: [CardInfo]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cardInfo <- map["data"]
    }
    
    public class CardInfo: Mappable {
        var no: Int?
        var ui_memberNo: Int?
        var uti_cardNo: Int?
        var date_collected: String?
        var ui_province: Int?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            ui_memberNo <- map["ui_memberNo"]
            uti_cardNo <- map["uti_cardNo"]
            date_collected <- map["date_collected"]
            ui_province <- map["ui_province"]
        }
    }
}
