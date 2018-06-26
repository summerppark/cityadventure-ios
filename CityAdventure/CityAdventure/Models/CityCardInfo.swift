//
//  CityCardInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 26..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class CityCardInfo: BaseResponse {
    
    var cityInfo: [CityData]?
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cityInfo <- map["data"]
    }
    
    public class CityData: Mappable {
        var s_name: String? // 서울
        var s_type: String? // 특별시
        var ui_province: String? // 0 특광역시 도 no
        var ui_cityNo: String?
        var uti_cardNo: String?
        var s_kanji: String? // 한자
        var t_kanjiExplain: String?
        var t_slogan: String?
        var t_cityExplain: String?
        var t_tourURL: String? // 도시투어 url
        var version: String?
        
        public required init?(map: Map) { }
        
        func mapping(map: Map) {
            s_name <- map["s_name"]
            s_type <- map["s_type"]
            ui_province <- map["ui_province"]
            ui_cityNo <- map["ui_cityNo"]
            uti_cardNo <- map["uti_cardNo"]
            s_kanji <- map["s_kanji"]
            t_kanjiExplain <- map["t_kanjiExplain"]
            t_slogan <- map["t_slogan"]
            t_cityExplain <- map["t_cityExplain"]
            t_tourURL <- map["t_tourURL"]
            version <- map["version"]
        }
    }
}
