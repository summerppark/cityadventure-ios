//
//  EmailChecker.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class EmailChecker: BaseResponse {
    var email_data : [String: Any] = [:]
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        email_data <- map["data"]
    }
    
    public class EmailData: Mappable {
        var no: Int?
        var s_mail: String?
        
        public required init?(map: Map) {}
        
        func mapping(map: Map) {
            no <- map["no"]
            s_mail <- map["s_mail"]
        }
    }
}
