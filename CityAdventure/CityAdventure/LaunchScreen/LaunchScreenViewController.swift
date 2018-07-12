//
//  LaunchScreenViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 23..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import AVFoundation
import Alamofire
import Toaster

class LaunchScreenViewController: BaseViewController {
    
    static var syntherSizer: AVSpeechSynthesizer?
    
    var cardCityDBPath : String = ""
    // gif
    @IBOutlet weak var loadGifImage: UIImageView! {
        didSet {
            let gifFile = UIImage.gif(name: "loading")
            loadGifImage.image = gifFile
        }
    }
    var presenter: LoginViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let effectable = UserDefaults.standard.object(forKey: "Effect") as? String {
            LaunchScreenViewController.syntherSizer = nil
        } else {
            LaunchScreenViewController.syntherSizer = AVSpeechSynthesizer()
        }
        
        
        toastViewSetting()
        // navi hidden
        // db 내용에 '' 가 포함되어 FMDB INSERT 쿼리문 에러발생.
        // BUNDLE -> CityCard 대체
//        makeDB()
//        insertDB()

        
        if let day = UserDefaults.standard.object(forKey: "NoticeOffDay") as? Int ,
            let month =  UserDefaults.standard.object(forKey: "NoticeOffMonth") as? Int {
            
            if month == Calendar.current.component(.month, from: Date()) {
                if day < Calendar.current.component(.day, from: Date()) {
                    // 같은 달 day 저장된 날짜가 작으면 공지뜨도록
                    UserDefaults.standard.set(nil, forKey: "Notice_Toggle")
                } else {
                    print("Notice_Toggle값이 있으므로 공지를 보여주지 않는다.")
                }
            } else {
                // 같은달이 아니면 무조건 뜨도록
                UserDefaults.standard.set(nil, forKey: "Notice_Toggle")
            }
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
        presenter = LoginViewPresenter(presenter: self)
        
    }
    
    func toastViewSetting() {
        ToastView.appearance().font = UIFont(name: "GodoM", size: 18.0)
        ToastView.appearance().frame = CGRect(x: 0, y: 0, width: 200, height: 150)
    }
    
    func makeDB() {
        let fileManager = FileManager.default
        var dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        dirPath!.append("/CityCardsInfo.db")
        print("경로", dirPath)
        
        if let path = dirPath {
            cardCityDBPath = path
        }
        
        if !fileManager.fileExists(atPath: dirPath!) {
            
            let contactDB = FMDatabase(path: dirPath!)
            if contactDB.open() {
                let createQuery = "CREATE TABLE IF NOT EXISTS CardCityInfo (ID INTEGER PRIMARY KEY AUTOINCREMENT, S_NAME TEXT, S_TYPE TEXT, UI_PROVINCE INTEGER, UI_CITYNO INTEGER, UTI_CARDNO INTEGER, S_KANJI TEXT, T_KANJIEXPLAIN TEXT, T_SLOGAN TEXT, T_CITYEXPLAIN TEXT, T_TOURURL TEXT, VERSION INTEGER)"
                
                if !contactDB.executeStatements(createQuery) {
                    print("contactDB Execute Fail", contactDB.lastError())
                }
                contactDB.close()
            }
        } else {
            print("이미 있다.")
        }
    }
    
    func insertDB() {
        Alamofire.request("http://www.bubu-expedition.com/API/v1/cityCards", method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<CityCardInfo>) in
            print("DBInfo",response.result.value)
            
            guard let city = response.result.value?.cityInfo else { return }
            let db = FMDatabase(path: self.cardCityDBPath)
            city.forEach({ (data) in
                if db.open() {
                    let insertSQL = "INSERT INTO CardCityInfo (S_NAME,S_TYPE ,UI_PROVINCE ,UI_CITYNO ,UTI_CARDNO ,S_KANJI ,T_KANJIEXPLAIN ,T_SLOGAN,T_CITYEXPLAIN,T_TOURURL,VERSION) VALUES ('\(data.s_name ?? "")', '\(data.s_type ?? "")', '\(data.ui_province ?? 999)', '\(data.ui_cityNo ?? 999)', '\(data.uti_cardNo ?? 999)', '\(data.s_kanji ?? "")', '\(data.t_kanjiExplain ?? "")', '\(data.t_slogan ?? "")', ' test\')', '\(data.t_tourURL ?? "")', '\(data.version ?? 999)')"
                    
                    do {
                        try db.executeUpdate(insertSQL, values: nil)
                    } catch {
                        print(db.lastError())
                    }
                    
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            [weak self] in 
            
            print("3초 후")
            // gif stop
            self?.loadGifImage.stopAnimating()
            
            if let email = UserDefaults.standard.object(forKey: "auto_email") as? String, let password = UserDefaults.standard.object(forKey: "auto_password") as? String {
               
                self?.presenter.tryEmailLogin(email: email, password: password)
            } else {
                // 로그인 화면으로 옵셔널 체크 후 전환
                if let loginVC = self?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                    self?.navigationController?.pushViewController(loginVC, animated: true)
                }
            }
        })
    }
}


extension LaunchScreenViewController: LoginViewPresenterProtocol {
    func tryLoginHandler(nick: String) {
        stopLoading()
        // email, password 를 통해서 API 를 날려 토큰을 받아 온 후 바로 Token 을 가지고 유저 정보, 유저 계정정보 2군두에 통신을 시도한 후 핸들러로 이곳에 도착하여 메인뷰로 넘어간다.
        // Toast 를 위한 구문
        failEmailLogin(msg: "\(nick)대원님 도시탐험 하러가요!")
        
        // Main 화면으로 보내기
        let main = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = main
    }
    
    func startLoading() {
        print("login시도중")
        super.showLoading(view: self.view)
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    func failEmailLogin(msg: String?) {
        print("실패를 알려준다 토스트 온")
        Toast(text: msg).show()
    }
}
