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
    
    //email 로그인
    static func postTryEmailLogin(email: String, password: String) -> String {
        return "/tokens?email=\(email)&password=\(password)"
    }
    
    
    // 비밀번호 찾기 이메일 인증
    static func findPassword(email: String) -> String {
        return "/passwordResetRequests?email=\(email)"
    }
    
    
    // 인증번호 체크
    static func authNumberCheck(email: String, number: String) -> String {
        return "/passwordResetRequests/\(number)?email=\(email)"
    }
}
