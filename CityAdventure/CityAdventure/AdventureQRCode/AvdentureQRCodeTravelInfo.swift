//
//  AvdentureQRCodeTravelInfo.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 12..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import WebKit

class AvdentureQRCodeTravelInfo: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation()
        setWebView()
    }
    
    func settingNavigation() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.title = "여행 정보"
        let closeBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeViewController))
        closeBarButtonItem.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    
    func setWebView() {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: "https://www.naver.com") {
                let request = URLRequest(url: url)
                DispatchQueue.main.async { [weak self] in
                    self?.webView.load(request)
                }
            }
        }
    }
    
    
    @objc func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension AvdentureQRCodeTravelInfo: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        super.showLoading(view: self.view)
    }
    
    // 로딩 끝
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.hideLoading()
    }
    
    
    
    
}
