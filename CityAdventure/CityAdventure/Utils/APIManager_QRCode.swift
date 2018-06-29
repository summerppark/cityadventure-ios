//
//  APIManager_QRCode.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 22..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension APIManager {
   
    static func getCityFromPuzzleGame(number: String,
                                      result: @escaping (EmailChecker?) -> ()) {
        
         guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
        
        
        Alamofire.request(APIUrls.getCityFromPuzzleUrl(number: number, token: token), method: .put, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<EmailChecker>) in
            print(APIUrls.getCityFromPuzzleUrl(number: number, token: token))
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    result(value)
                }
            case .failure(let error):
                result(nil)
            }
            
        }
    }
    
    static func getMyCollectedCityList(memberId: String,
                                       result: @escaping (UserCardInfo?) -> ()) {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
        Alamofire.request(APIUrls.getMyCollectedCityList(member: memberId, token: token), method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<UserCardInfo>) in
            print("===> ",APIUrls.getMyCollectedCityList(member: memberId, token: token))
            switch response.result {
            case .success:
                if let value = response.result.value {
                    result(value)
                }
            case .failure(let error):
                print(error.localizedDescription)
                result(nil)
            }
        }
    }
}
