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

class LaunchScreenViewController: UIViewController {
    
    static var syntheSizer = AVSpeechSynthesizer()
    
    var cardCityDBPath : String = ""
    // gif
    @IBOutlet weak var loadGifImage: UIImageView! {
        didSet {
            let gifFile = UIImage.gif(name: "loading")
            loadGifImage.image = gifFile
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navi hidden
        // db 내용에 '' 가 포함되어 FMDB INSERT 쿼리문 에러발생.
        // BUNDLE -> CityCard 대체
//        makeDB()
//        insertDB()

        self.navigationController?.navigationBar.isHidden = true
        
        
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
            
            
            // 로그인 화면으로 옵셔널 체크 후 전환
            if let loginVC = self?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                self?.navigationController?.pushViewController(loginVC, animated: true)
            }
        })
    }
}
