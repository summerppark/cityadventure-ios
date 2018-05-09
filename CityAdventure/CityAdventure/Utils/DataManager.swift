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
    var exerciseHintList: [ExerciseGameDB] = []
    var randomChar: [String] = []
    var randomCharArray:[String] = []
    
    
    static var adventureExercise: Int = 0
    static let shared: DataManager = DataManager()
    
    init() {
        // 도시정보를 가져온다.
        let db = Bundle.main.path(forResource: "cityNumber", ofType: "sqlite")
        let path = FMDatabase(path: db)
        if path.open() {
            let fetchData = "SELECT * FROM cityNumber"
            guard let results: FMResultSet = path.executeQuery(fetchData, withArgumentsIn: []) else { return }
            
            while results.next() == true {
                let cityInfo = CityNumbersDB.init(number: results.int(forColumn: "no"),
                                                  cityName: results.string(forColumn: "s_name") ?? "",
                                                  cityType: results.string(forColumn: "s_type") ?? "",
                                                  provinceType: results.int(forColumn: "ui_province"),
                                                  areaName: results.string(forColumn: "s_area") ?? "")
                randomChar.append(cityInfo.cityName)
                citynumbers.append(cityInfo)
            }
        }
        path.close()
        
        
        // 힌트정보를 가져온다.
        
        let hintDB = Bundle.main.path(forResource: "prepareDB", ofType: "sqlite")
        print("HintDB",hintDB)
        let hintPath = FMDatabase(path: hintDB)
        print("hintPath", hintPath)
        if hintPath.open() {
            let fetchData = "SELECT * FROM prepareDB"
            guard let results: FMResultSet = hintPath.executeQuery(fetchData, withArgumentsIn: []) else { return }
            
            while results.next() == true {
                let hintInfo = ExerciseGameDB.init(number: results.string(forColumn: "no") ?? "",
                                                   hint: results.string(forColumn: "hint") ?? "" )
                
                exerciseHintList.append(hintInfo)
            }
        }

        hintPath.close()
    }
    
  
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
        dump(response)
        userAccountInfo = response
    }

    public func setUserCardInfo(response: UserCardInfo) {
        userCardInfo = response
    }
    
    public func getUserCardInfo() -> UserCardInfo?{
        return userCardInfo
    }
    
}
