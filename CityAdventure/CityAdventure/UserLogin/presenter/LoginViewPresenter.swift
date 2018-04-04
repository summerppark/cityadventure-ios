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
    func tryLoginHandler(userInfo: loginResponse)
    func failEmailLogin(msg: String?)
}

class LoginViewPresenter: NSObject {
    var presenter: LoginViewPresenterProtocol!
    
    init(presenter: LoginViewPresenterProtocol) {
        self.presenter = presenter
    }
    
    // 서버로 통신
    func tryEmailLogin(email: String, password: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.postTryEmailLogin(url: APIUrls.postTryEmailLogin(email: email, password: password), completion: { (result, error) in
            if error == nil {
                dump(result)
                print("성공한 데이타를 받아와서 프리젠트 프로토콜로 뿌려줌")
                self.presenter.tryLoginHandler(userInfo: result)
            }
            self.presenter.stopLoading()
            
        }) { (msg, err) in
            print(msg!)
            self.presenter.failEmailLogin(msg: msg)
            self.presenter.stopLoading()
        }
    }
    
    
}
