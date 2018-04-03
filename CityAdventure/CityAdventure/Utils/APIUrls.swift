//
//  APIUrls.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation

class APIUrls {
    // 이메일 인증
    static func getValidEmailAddress(email: String,userType: String = "0") -> String {
        return "/accounts/findEmail?email=\(email)&userType=\(userType)"
    }
    
    // 회원 가입
    static func getSignUpUrls(params: [String: String]) -> String {
        return "/accounts?name=\(params["name"]!)&email=\(params["email"]!)&kakaoId=\(params["kakaoId"]!)&homeProvince=\(params["homeProvince"]!)&password=\(params["password"]!)&gender=\(params["gender"]!)&birth=\(params["birth"]!)&homeCity=\(params["homeCity"]!)&livingCity=\(params["livingCity"]!)&livingProvince=\(params["livingProvince"]!)&userLoginType=\(params["userLoginType"]!)&avatarNo=\(params["avatarNo"]!)"
    }
}
