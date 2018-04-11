//
//  FindPasswordSecondPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 9..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

protocol FindPasswordSecondPresenterProtocol: BasePresenterProtocol {
    func presentAlert(isSuccess: Bool)
}


class FindPasswordSecondPresenter: NSObject {
    var presenter: FindPasswordSecondPresenterProtocol!
    init(presenter: FindPasswordSecondPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    // 인증번호 확인.
    func tryAccessNumberCheck(email: String, number: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        
        APIManager.authNumberCheck(url: APIUrls.authNumberCheck(email: email, number: number),completion:  { (result, error) in
            if error == nil {
                switch result {
                case "성공":
                    self.presenter.presentAlert(isSuccess: true)
                case "실패":
                    self.presenter.presentAlert(isSuccess: false)
                default:
                    print("No Response Case")
                }
            }
            self.presenter.stopLoading()
        }) { (error) in
            print("EMAIL CHECKER ERROR")
            self.presenter.stopLoading()
        }
    }
}

