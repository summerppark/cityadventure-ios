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
    var groupCities: [Int32: [String]] = [Int32:[String]]()
    var cityCards: [CityCardLocalDB] = []
    
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
                                                  areaName: results.string(forColumn: "s_area") ?? "", hint: results.string(forColumn: "s_hint") ?? "")
                
                groupCities[cityInfo.provinceType]?.append(cityInfo.cityName)
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
        
        
        let cityCard = Bundle.main.path(forResource: "citycard", ofType: "sqlite")
        let cityCardDB = FMDatabase(path: cityCard)
        
        if cityCardDB.open() {
            let fetchQuery = "SELECT * FROM citycard"
            guard let results: FMResultSet = cityCardDB.executeQuery(fetchQuery, withArgumentsIn: []) else {
                print("실패")
                return }
            
            while results.next() == true {
                let col = CityCardLocalDB.init(s_name: results.string(forColumn: "s_name") ?? "",
                                     s_type: results.string(forColumn: "s_type") ?? "",
                                     ui_cityNo: results.int(forColumn: "ui_cityNo"),
                                     ui_cardNo: results.int(forColumn: "ui_cardNo"),
                                     s_kanji: results.string(forColumn: "s_kanji") ?? "",
                                     t_kanjiExplain: results.string(forColumn: "t_kanjiExplain") ?? "",
                                     t_slogan: results.string(forColumn: "t_slogan") ?? "",
                                     t_cityExplain: results.string(forColumn: "t_cityExplain") ?? "",
                                     t_tourURL: results.string(forColumn: "t_tourURL") ?? "",
                                     version: results.int(forColumn: "version"), ui_province: results.int(forColumn: "ui_province"), latitude: Float(results.double(forColumn: "latitude")), longitude: Float(results.double(forColumn: "longitude")))
                
                cityCards.append(col)
            }
        }
        cityCardDB.close()
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
    public func updateUserInfo(exp: Int, coin: Int) {
        userInfo?.userInfo?.ui_exp = exp
        userInfo?.userInfo?.ui_credit = coin
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
    
    public func bgmControl() {
        BGMPlayerManager.shared.bgmStart()
    }
}
