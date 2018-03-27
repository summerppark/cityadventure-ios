//
//  Account.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import ObjectMapper

class Account: Mappable {
    var userLoginType: String?
    var email: String?
    var password: String?
    var kakaoId: String?
    var name: String?
    var gender: String?
    var homeProvince: String?
    var homeCity: String?
    var livingProvince: String?
    var livingCity: String?
    var birth: String?
    var avatarNo: String?
    
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userLoginType <- map["userLoginType"]
        email <- map["email"]
        password <- map["password"]
        kakaoId <- map["kakaoId"]
        name <- map["name"]
        gender <- map["gender"]
        homeProvince <- map["homeProvince"]
        homeCity <- map["homeCity"]
        livingProvince <- map["livingProvince"]
        livingCity <- map["livingCity"]
        birth <- map["birth"]
        avatarNo <- map["avatarNo"]
    }
}
