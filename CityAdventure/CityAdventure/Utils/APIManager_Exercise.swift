//
//  APIManager_Exercise.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 22..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

extension APIManager {
    
    static func updateMyExpCoin(url: String, completion: @escaping (NSDictionary) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        
        
        Alamofire.request("\(server_url)\(url)", method: .post, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 200:
                print("UpdateCoin", url, response.result.value)
                if let dic = response.result.value as? NSDictionary {
                    completion(dic)
                }
            default:
                fail(response.error)
            }
        }
    }
}
