//
//  LoginResponse.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 4..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper


class loginResponse: BaseResponse {
    //정보
    var loginResponse: LoginData?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        // 상속받은것도 맵핑 해주어야함.
    
        super.mapping(map: map)
        loginResponse <- map["data"]
    }
    
    public class LoginData: Mappable {
        var accountNo: Int?
        var memberNo: Int?
        var date: String?
        var token: String?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            accountNo <- map["accountNo"]
            memberNo <- map["memberNo"]
            date <- map["date"]
            token <- map["token"]
        }
    }
}

