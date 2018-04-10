//
//  UserInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfo: BaseResponse {
    var userInfo: UserCharInfo?

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userInfo <- map["data"]
    }
    
    public class UserCharInfo: Mappable {
        var no: Int?
        var ui_accountNo: Int?
        var s_name: String?
        var ui_avatarNo: Int?
        var c_gender: String?
        var date_birth: String?
        var ui_homeProvince: Int?
        var ui_homeCity: Int?
        var ui_livingProvince: Int?
        var ui_livingCity: Int?
        var ui_credit: Int?
        var ui_exp: Int?
        var date_registed: String?
        var s_listOfAvatarNo: [Int]?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            ui_accountNo <- map["ui_accountNo"]
            s_name <- map["s_name"]
            ui_avatarNo <- map["ui_avatarNo"]
            c_gender <- map["c_gender"]
            date_birth <- map["date_birth"]
            ui_homeProvince <- map["ui_homeProvince"]
            ui_homeCity <- map["ui_homeCity"]
            ui_livingProvince <- map["ui_livingProvince"]
            ui_livingCity <- map["ui_livingCity"]
            ui_credit <- map["ui_credit"]
            ui_exp <- map["ui_exp"]
            date_registed <- map["date_registed"]
            s_listOfAvatarNo <- map["s_listOfAvatarNo"]
        }
    }
}
