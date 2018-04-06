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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        self.presenter.presentAlertView(text: email)
        self.presenter.stopLoading()
    }
}
