//
//  EmailChecker.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class EmailChecker: Mappable {
    
    var responseCode: String?
    var message: String?
    var dataLength: Int?
    var email_data : [String: Any] = [:]
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        responseCode <- map["responseCode"]
        message <- map["message"]
        dataLength <- map["dataLength"]
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
