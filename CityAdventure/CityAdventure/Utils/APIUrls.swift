//
//  APIUrls.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation

class APIUrls {
    static func getValidEmailAddress(email: String,userType: String = "0") -> String {
        return "/accounts/findEmail?email=\(email)&userType=\(userType)"
    }
}
