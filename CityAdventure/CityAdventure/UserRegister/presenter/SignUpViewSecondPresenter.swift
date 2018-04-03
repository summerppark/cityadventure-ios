//
//  SignUpViewSecondPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Alamofire

//BasePresenterProtocol
@objc protocol BasePresenterProtocol {
    func startLoading() -> Void
    func stopLoading() -> Void
}

protocol SignUpViewSecondPresenterProtocol: BasePresenterProtocol {
    func presentAlertView(text: String)
}



class SignUpViewSecondPresenter: NSObject {
    var presenter: SignUpViewSecondPresenterProtocol!
    
    init(presenter: SignUpViewSecondPresenterProtocol) {
        self.presenter = presenter
    }
    
    func isValidEmailAddress(email: String) {
        //통신 중임을 표시
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.getIsValidEmailAddress(url: APIUrls.getValidEmailAddress(email: email), completion: { (resultsString, error) in
            if error == nil {
                self.presenter.presentAlertView(text: resultsString)
            }
            self.presenter.stopLoading()
        }) { (error) in
            print("EMAIL CHECKER ERROR")
            self.presenter.stopLoading()
        }
    }
}
