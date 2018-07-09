//
//  ExerciseGamePresenter.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 22..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
protocol ExerciseGamePresenterProtocol: BasePresenterProtocol {

}

class ExerciseGamePresenter: NSObject {
    var presenter: ExerciseGamePresenterProtocol!
    
    init(presenter: ExerciseGamePresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func updateMyAccountInfo() {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
        APIManager.updateMyExpCoin(url: APIUrls.updateExpCoin(token: token, credit: 50, exp: 50), completion: { (result) in
            
            // 나의 계정정보를 갱신.
            if let updateInfo = result["data"] as? NSDictionary {
                if let credit = updateInfo["ui_credit"] as? Int,
                let exp = updateInfo["ui_exp"] as? Int {
                    DataManager.shared.userInfo?.userInfo?.ui_credit = credit
                    DataManager.shared.userInfo?.userInfo?.ui_exp = exp
                }
                print("성공성공", updateInfo["ui_credit"] as! Int, updateInfo["ui_exp"] as! Int , token, APIUrls.updateExpCoin(token: token, credit: 50, exp: 50))
            }
        }) { (error) in
            print(error!.localizedDescription , "통신 실패 UpdateMyAccountInfo")
        }
    }
    
    
}
