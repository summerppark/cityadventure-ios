//
//  DataManager.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 30..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import GRDB



class DataManager {
    // 고향,사는곳 선택하는 DB
    var citynumbers: [CityNumbersDB] = []
    static let shared: DataManager = DataManager()
    
    // 싱글턴 유저정보
    var userInfo: UserInfo?
    var userAccountInfo: UserAccountInfo?
    var userCardInfo: UserCardInfo?
    
 
    // 유저 정보를 가져온다.
    public func getUserInfo() -> UserInfo? {
        return userInfo
    }
    
    // 유저 정보를 저장한다.
    public func setUserInfo(response: UserInfo) {
        userInfo = response
    }

    public func getUserAccountInfo() -> UserAccountInfo? {
        return userAccountInfo
    }
    
    public func setUserAccountInfo(response: UserAccountInfo) {
        userAccountInfo = response
    }

    public func setUserCardInfo(response: UserCardInfo) {
        userCardInfo = response
    }
    
    public func getUserCardInfo() -> UserCardInfo?{
        return userCardInfo
    }
    
}
