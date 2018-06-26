//
//  CityCardInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 26..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

struct CityCardLocalDB {
    var s_name: String // 서울
    var s_type: String // 특별시
    var ui_province: Int32 // 0 특광역시 도 no
    var ui_cityNo: Int32
    var uti_cardNo: Int32
    var s_kanji: String // 한자
    var t_kanjiExplain: String
    var t_slogan: String
    var t_cityExplain: String
    var t_tourURL: String // 도시투어 url
    var version: Int32
    
    init(s_name: String, s_type: String, ui_province: Int32, ui_cityNo: Int32, uti_cardNo: Int32, s_kanji: String, t_kanjiExplain: String, t_slogan: String, t_cityExplain: String, t_tourURL: String, version: Int32) {
        self.s_name = s_name
        self.s_type = s_type
        self.ui_province = ui_province
        self.ui_cityNo = ui_cityNo
        self.uti_cardNo = uti_cardNo
        self.s_kanji = s_kanji
        self.t_kanjiExplain = t_kanjiExplain
        self.t_slogan = t_slogan
        self.t_cityExplain = t_cityExplain
        self.t_tourURL = t_tourURL
        self.version = version
    }
}

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
        var ui_province: Int? // 0 특광역시 도 no
        var ui_cityNo: Int?
        var uti_cardNo: Int?
        var s_kanji: String? // 한자
        var t_kanjiExplain: String?
        var t_slogan: String?
        var t_cityExplain: String?
        var t_tourURL: String? // 도시투어 url
        var version: Int?
        
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
