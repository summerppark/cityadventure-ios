//
//  FindPasswordPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Alamofire

protocol FindPasswordPresenterProtocl: BasePresenterProtocol {
    func presentAlertView(text: String)
}


class FindPasswordPresenter: NSObject {
    var presenter: FindPasswordPresenterProtocl!
    init(presenter: FindPasswordPresenterProtocl) {
        self.presenter = presenter
    }
    
    func findPassword(email: String) {
        //통신 중임을 표시
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.findPassword(url: APIUrls.findPassword(email: email), completion: { (resultsString, error) in
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

