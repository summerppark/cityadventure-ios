//
//  SignUpFinalPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 3..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


protocol SignUpFinalPresenterProtocol: BasePresenterProtocol {
    func signUpResult(text: String)
}

// Presenter
class SignUpFinalPresenter: NSObject {
    var presenter: SignUpFinalPresenterProtocol!
    
    init(presenter: SignUpFinalPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func connectPostSignUp(parameter: [String: String]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.postRegisterUserInfo(url: APIUrls.getSignUpUrls(params: parameter), completion: { (resultString, error) in
            
            if error == nil {
                self.presenter.signUpResult(text: resultString)
            }
            self.presenter.stopLoading()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }) { (error)  in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.presenter.stopLoading()
            print("회원가입부분에서 에러가 발생했습니다.", error?.localizedDescription ?? "")
        }
    }
}
