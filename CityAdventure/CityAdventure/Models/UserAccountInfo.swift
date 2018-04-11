//
//  UserAccountInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class UserAccountInfo: BaseResponse {
    var userAccountInfo: UserAccountInfoData?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userAccountInfo <- map["data"]
    }
    
    public class UserAccountInfoData: Mappable {
        var no: Int?
        var s_email: String?
        var s_password: String?
        var t_serial: Int?
        var ti_state: Int?
        var s_phone: String?
        var date_registed: String?
        var date_updated: String?
        var date_withdraw: String?
        var user_login_type: Int?
        var kakao_id: Int?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            s_email <- map["s_email"]
            s_password <- map["s_password"]
            t_serial <- map["t_serial"]
            ti_state <- map["ti_state"]
            s_phone <- map["s_phone"]
            date_registed <- map["date_registed"]
            date_updated <- map["date_updated"]
            date_withdraw <- map["date_withdraw"]
            user_login_type <- map["user_login_type"]
            kakao_id <- map["kakao_id"]
        }
    }
}

