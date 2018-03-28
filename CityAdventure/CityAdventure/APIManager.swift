//
//  APIManager.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



struct APIManager {
    static let server_url = "http://www.bubu-expedition.com/API/v1"
    
    
    static func getIsValidEmailAddress(url: String, completion: @escaping (String, _ error: Error?) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<EmailChecker>) in
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 200 :
                completion("이미 사용된 메일 주소여서 또 사용할 수 없어요. \n다른 메일을 입력해 주세요.", nil)
            case 404 :
                completion("사용가능한 메일입니다. \n회원가입을 계속 진행해주세요!", nil)
            default:
                completion("잘못된 형식의 이메일입니다. \n이메일주소를 확인해주세요.", nil)
            }
        }
    }
}
