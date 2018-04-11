//
//  LoginViewPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 4..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol LoginViewPresenterProtocol: BasePresenterProtocol {
    func tryLoginHandler(nick: String)
    func failEmailLogin(msg: String?)
}

class LoginViewPresenter: NSObject {
    var presenter: LoginViewPresenterProtocol!
    
    init(presenter: LoginViewPresenterProtocol) {
        self.presenter = presenter
    }
    
    var memberNumber: Int = 0
    var token: String = ""
  
    
    // Email, password 값으로 로그인을 시도하여 받아온 토큰값으로 유저정보,를 얻기 위해 통신을 더 보내는 부분
    func getInfo() {
        // 유저 캐릭터 정보를 받아오는부분.
        print(token)
        APIManager.getUserInfo(url: APIUrls.getUserInfo(memberNo: memberNumber, token: token), completion: { (userInfo, error) in
            DataManager.shared.setUserInfo(response: userInfo)
            self.presenter.tryLoginHandler(nick: userInfo.userInfo?.s_name ?? "님")
        })
        
        APIManager.getUserAccountInfo(url: APIUrls.getUserAccountInfo(token: token), completion: { (accountInfo, error) in
            DataManager.shared.setUserAccountInfo(response: accountInfo)
        })
    }
    
    
    func getCardInfo() {
        APIManager.getMyCardList(url: APIUrls.getCardlistInfo(token: token, number: memberNumber)) { (cardInfo, error) in
            DataManager.shared.setUserCardInfo(response: cardInfo)
            self.getInfo()
        }
    }
    
    
    // 서버로 통신
    func tryEmailLogin(email: String, password: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.postTryEmailLogin(url: APIUrls.postTryEmailLogin(email: email, password: password), completion: { (result, error) in
            if error == nil {
                if let responseData = result.loginResponse, let member = responseData.memberNo, let token = responseData.token {
                    self.memberNumber = member
                    self.token = token
                    
                    // 토큰정보를 받아와서 추가적인 서버와 통신한다.
                    self.getCardInfo()
                }
            }
            self.presenter.stopLoading()
            
        }) { (msg, err) in
            print(msg!)
            self.presenter.failEmailLogin(msg: msg)
            self.presenter.stopLoading()
        }
    }
    
    
    
}
