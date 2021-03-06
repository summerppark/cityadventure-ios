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
    
    // 유저 캐릭터정보, 개인정보
    static func getUserInfo(memberNo: Int, token: String) -> String {
        return "/members/\(memberNo)?token=\(token)"
    }
    
    // 유저 계정정보
    static func getUserAccountInfo(token: String) -> String {
        return "/accounts/accountByToken?token=\(token)"
    }
    
    // 카드 정보.
    static func getCardlistInfo(token: String, number: Int) -> String {
        return "/members/\(number)/cardCollectingLogs?token=\(token)"
    }
    
    // 비밀번호 변경
    static func changePassword(token: String, password: String) -> String {
        return "/accounts/password?token=\(token)&password=\(password)"
    }
    
    // 준비운동 코인 ,경험치
    static func updateExpCoin(token: String, credit: Int, exp: Int) -> String {
        return "/members/credit-exp?token=\(token)&credit=\(credit)&exp=\(exp)"
    }
    
    
    static func hintExpCoin(token: String) -> String {
        return "http://www.bubu-expedition.com/API/v1/members/credit-exp?token=\(token)&credit=-300&exp=0"
    }
   

    
    static func getImageFlipFront(cardNumber: String) -> String {
        return "http://www.bubu-expedition.com/resources/CardFront_final/\(cardNumber).png"
    }
    
    static func getImageMinimap(cardNumber: String) -> String {
        return "http://www.bubu-expedition.com/resources/minimaps/\(cardNumber).png"
    }
    
    static func getImagelandMark(cardNumber: String, index: String) -> String {
        return "http://www.bubu-expedition.com/resources/landmarks/\(cardNumber)/\(index).png"
    }
    
    static func getPuzzleImage(cardNumber: String) -> String {
        return "http://www.bubu-expedition.com/resources/puzzleimages/\(cardNumber).png"
    }
    
    static func getCityStatistics(index: String) -> String {
        return "http://www.bubu-expedition.com/API/v1/cities/\(index)/statistics"
    }
    
    static func getKanjiExpMp3Loading(index: String, type: String) -> String {
        return "http://www.bubu-expedition.com/resources/sounds/mp3/\(index)/\(type).mp3"
    }
    
    static func getCityFromPuzzleUrl(number: String, token: String) -> String {
        return "http://www.bubu-expedition.com/API/v1/cityPuzzleSessions/\(number)/submit?token=\(token)"
    }
    
    static func getMycityCardList(member: String, token: String) -> String {
        return  "http://www.bubu-expedition.com/API/v1/members/\(member)/cardCollectingLogs?token=\(token)"
    }
    
    static func getMyCollectedCityList(member: String, token: String) -> String {
        return "http://www.bubu-expedition.com/API/v1/members/\(member)/cardCollectingLogs?token=\(token)"
    }
    
    static func getLandmarks(number: String) -> String {
        return "http://www.bubu-expedition.com/API/v1/cities/\(number)/landmarks"
    }
    
    static func getMyExpCoinUpdatePuzzleSuccess(member: Int) -> String {
        return "http://www.bubu-expedition.com/API/v1/members/\(member)/credit-exp"
    }
    
    static func shoppingMallUrl() -> String {
        return "https://smartstore.naver.com/bubuinc"
    }
    
    
    static func leaveBubuApp(member: Int, token: String, email: String, subject: String, content: String, type: Int) -> String {
        return "http://www.bubu-expedition.com/API/v1/accounts/\(member)/sendmail?token=\(token)&email=\(email)&subject=\(subject)&content=\(content)&type=\(type)"
    }
    
    static func getLandmarkDetail(number: Int) -> String {
        return "http://www.bubu-expedition.com/API/v1/landmarks/\(number)"
    }
    
    static func getTourApi(search: String) -> String {
//        return "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?ServiceKey=1bRQ7kZKeN7M%2FGK5dO6r7VZfTFPgmhkWKrwe3iyfRBQ549JRKV%2BqRY4qQiIO0EpShrSEwCWb90OKNqcOGxv8Cg%3D%3D&numOfRows=10&pageNo=1&MobileOS=IOS&MobileApp=cityadventure&keyword=\(search)&_type=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let search = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        return "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?ServiceKey=1bRQ7kZKeN7M%2FGK5dO6r7VZfTFPgmhkWKrwe3iyfRBQ549JRKV%2BqRY4qQiIO0EpShrSEwCWb90OKNqcOGxv8Cg%3D%3D&numOfRows=10&pageNo=1&MobileOS=IOS&MobileApp=cityadventure&keyword=\(search)&_type=json"
    }
    
    
    static func getEditMyInfo(token: String, memberNumber: Int, homeProvince: Int32, homeCity: Int32, livingProvince: Int32, livingCity: Int32, name: String, gender: String, birth: String ) -> String {
        return "http://www.bubu-expedition.com/API/v1/members/\(memberNumber)?token=\(token)&homeProvince=\(homeProvince)&homeCity=\(homeCity)&livingProvince=\(livingProvince)&livingCity=\(livingCity)&name=\(name)&gender=\(gender)&birth=\(birth)"
    }
    
    
    static func getUpdateAvatarInfo(token: String, index: Int, member: Int) -> String{
        return "http://www.bubu-expedition.com/API/v1/members/\(member)?token=\(token)&avatarNo=\(index)"
    }
    
}
