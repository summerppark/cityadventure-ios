//
//  APIGetUserInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 10..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension APIManager {
    static func getUserInfo(url: String, completion: @escaping (UserInfo, _ error: Error?) -> Void) {
        //유저 정보를 저장한다.
        Alamofire.request("\(server_url)\(url)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<UserInfo>) in
            if let userInfo = response.result.value {
                print("유저 캐릭터 정보, 유저정보를 받아오는 부분 ")
                print(userInfo.userInfo?.s_name)
                completion(userInfo, nil)
            }
        }
    }
    
    static func getUserAccountInfo(url: String, completion: @escaping (UserAccountInfo, _ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<UserAccountInfo>) in
            if let accountInfo = response.result.value {
                print("유저 계정 정보를 받아오는 부분")
                print(accountInfo.userAccountInfo?.s_email)
                completion(accountInfo, nil)
            }
        }
    }
    
    static func getMyCardList(url: String, completion: @escaping (UserCardInfo, _ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<UserCardInfo>) in
            if let cardInfo = response.result.value {
                print("!!!")
                print(cardInfo.cardInfo?.count)
                completion(cardInfo, nil)
            }
        }
    }
}
