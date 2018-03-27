//
//  SignUpViewModel.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 27..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import RxSwift

struct SignUpViewModel {
    var email = Variable<String>("")
    var retryEmail = Variable<String>("")
    var password = Variable<String>("")
    var retryPassword = Variable<String>("")

    // 이메일 일치하는지 체크
    var isValidRetryEmail: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), retryEmail.asObservable()) {
            (email, retryEmail) in
            email == retryEmail && !retryEmail.isEmpty
        }
    }
    
    // 비밀번호 8자리 이상 숫자+영어
    var isValidPassword: Observable<Bool> {
        return Observable.combineLatest([password.asObservable()]) {
            (password) in
            (password.first?.isPasswordValid())!
        }
    }
    
    
    // 비밀번호 같은지
    var isValidRetryPassword: Observable<Bool> {
        return Observable.combineLatest(retryPassword.asObservable(), password.asObservable()) {
            (password, retryPassword) in
            password == retryPassword && !retryPassword.isEmpty
        }
    }
    

    
    // 모든 항목이 올바른지
    var isAllValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(),
                                        retryEmail.asObservable(),
                                        password.asObservable(),
                                        retryPassword.asObservable()) {
            (email, retryEmail, password, rePassword) in
                                            email.validEmailAddress && email == retryEmail && password == rePassword && password.isPasswordValid() && rePassword.isPasswordValid()
        }
    }



}
