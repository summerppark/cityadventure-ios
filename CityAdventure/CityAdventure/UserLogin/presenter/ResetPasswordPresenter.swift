//
//  ResetPasswordPresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit


protocol ResetPasswordPresenterProtocol: BasePresenterProtocol {
    func changePasswordResult(message: String)
}

class ResetPasswordPresenter: NSObject {
    var presenter: ResetPasswordPresenterProtocol!
    init(presenter: ResetPasswordPresenterProtocol) {
        self.presenter = presenter
    }
    
    func tryChangePassword(token: String, password: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.presenter.startLoading()
        APIManager.changePassword(url: APIUrls.changePassword(token: token, password: password), completion: { (result, error) in
            var str = ""
            if error == nil {
                switch result {
                case "성공":
                    str = "비밀번호가 변경되었습니다. \n다시 로그인 해주세요~"
                    self.presenter.changePasswordResult(message: str)
                case "실패":
                    str = "에러가 발생되었습니다. \n다시 시도해주세요"
                    self.presenter.changePasswordResult(message: str)
                default:
                    print("No Result")
                    break
                }
            }
            self.presenter.stopLoading()
        }) {
            (error) in
            print("Error - changePassword")
            self.presenter.stopLoading()
        }
    }
}
