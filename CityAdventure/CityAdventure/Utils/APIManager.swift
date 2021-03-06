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
    
    // 이메일 인증
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
    
    
    // 회원 가입
    static func postRegisterUserInfo(url: String,  completion: @escaping (String, _ error: Error?) -> Void, fail: @escaping (_ error: Error?) -> Void) {
       
        Alamofire.request("\(server_url)\(url)", method: .post, encoding: JSONEncoding.default).responseObject { (response: DataResponse<BaseResponse>) in
             guard let statusCode = response.result.value?.responseCode else { return }
            
            print(statusCode, "ASDASDASDASD")
            dump(response.result.value)
            switch statusCode {
            case "201":
                print("성공케이스")
                completion("성공", nil)
            default :
                fail(response.error)
                print("실패케이스")
            }
        }
    }
    
    // 이메일 로그인
    static func postTryEmailLogin(url: String, completion: @escaping (loginResponse, _ error: Error?) -> Void, fail: @escaping (_ message: String?, _ error: Error?) -> Void) {
        print("1212, \(server_url)\(url)")
        Alamofire.request("\(server_url)\(url)", method: .post, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<loginResponse>) in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 201:
                completion(response.result.value!, nil)
                print("성공")
            case 400:
                print("실패")
                fail(response.result.value?.message, response.error)
            default:
                print("postTryEmailLogin 문제가 발생하였습니다.")
            }
        }
    }
    
    
    // 비밀번호 찾기 이메일 체크
    static func findPassword(url: String, completion: @escaping (String, _ error: Error?) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .post, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<BaseResponse>) in
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 201 :
                completion("인증번호 전송 완료.", nil)
            case 400 :
                completion("등록된 이메일이 아닙니다.", nil)
            default:
                completion("인증번호 전송 실패!", nil)
            }
        }
    }
    
    // 인증번호 체크
    static func authNumberCheck(url: String, completion: @escaping (String, _ error: Error?) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .delete, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<BaseResponse>) in
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 201:
                completion("성공", nil)
            case 401:
                completion("실패", nil)
            default:
                print("연결실패")
                return
            }
        }
    }
    
    static func changePassword(url: String, completion: @escaping (String, _ error: Error?) -> Void, fail: @escaping (_ error: Error?) -> Void) {
        Alamofire.request("\(server_url)\(url)", method: .put, parameters: nil, encoding: JSONEncoding.default).response { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 200 :
                completion("성공", nil)
            default:
                completion("실패", nil)
            }
        }
    }
    
    static func updateExpCoinAfterPuzzleSuccess(url: String) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 200 :
                print("Success")
                if let dict = response.result.value as? NSDictionary, let info = dict["data"] as? NSDictionary, let credit = info["ui_credit"] as? Int, let exp = info["ui_exp"] as? Int  {
                    DataManager.shared.userInfo?.userInfo?.ui_credit = credit
                    DataManager.shared.userInfo?.userInfo?.ui_exp = exp
                    
                }
                
            default:
                print("ERror puzzleSucces")
            }
        }
    }
}
