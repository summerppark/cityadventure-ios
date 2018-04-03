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
        print("===")
        dump(parameter)
        APIManager.postRegisterUserInfo(url: APIUrls.getSignUpUrls(params: parameter), completion: { (resultString, error) in
            
            if error == nil {
                self.presenter.signUpResult(text: resultString)
            }
            print("일로 넘어오나요")
            self.presenter.stopLoading()
        }) { (error) in
            print("회원 가입 실패요")
            self.presenter.stopLoading()
        }
    }
}
