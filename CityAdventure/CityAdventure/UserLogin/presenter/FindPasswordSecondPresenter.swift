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
    
    
    func tryAccessNumberCheck(email: String, number: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.findPassword(url: APIUrls.findPassword(email: email), completion: { (resultsString, error) in
            if error == nil {
                self.presenter.presentAlert(isSuccess: true)
            }
            self.presenter.stopLoading()
        }) { (error) in
            print("EMAIL CHECKER ERROR")
            self.presenter.stopLoading()
        }
    }
}

