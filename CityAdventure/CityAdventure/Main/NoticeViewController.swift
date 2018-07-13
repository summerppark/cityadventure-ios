//
//  NoticeViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 6..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import WebKit

class NoticeViewController: BaseViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var toggleButton: UIImageView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    @IBOutlet weak var leftbackbutton: UIButton!
    
    var toggle: Bool = false
    let images = [#imageLiteral(resourceName: "btn_checkOn_gender"),#imageLiteral(resourceName: "btn_check_gender")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        setNoticeWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if webView.canGoBack {
            leftbackbutton.isHidden = false
        } else {
            leftbackbutton.isHidden = true
        }
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    func setNoticeWebView() {
        // 공지사항 웹뷰 설정.
        //비동기로 처리 후 메인으로 돌려줌
        
        
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: "http://www.bubu-expedition.com/notice/notice.html") {
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
                DispatchQueue.main.async { [weak self] in
                    self?.webView.load(request)
                }
            }
        }
    }
    
    @IBAction func close() {
        // 닫을 때 현재 토글값을 로컬에 저장하여, 로그아웃 후 로그인 하였을 때 공지사항을 보여줄지 말지 컨트롤하는 것을 구현한다.
        
        if toggle {
            print("저장")
            UserDefaults.standard.set("NoticeOff", forKey: "Notice_Toggle")
            UserDefaults.standard.set(Calendar.current.component(.day, from: Date()), forKey: "NoticeOffDay")
            UserDefaults.standard.set(Calendar.current.component(.month, from: Date()), forKey: "NoticeOffMonth")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
   
    
    // 웹뷰 로딩 시작할 때
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        URLCache.shared.removeAllCachedResponses()
        super.showLoading(view: self.view)
        if webView.canGoBack {
            leftbackbutton.isHidden = false
        } else {
            leftbackbutton.isHidden = true
        }
        
    }
    
    // 웹뷰 로딩 끝낫을 때
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.hideLoading()
        if webView.canGoBack {
            leftbackbutton.isHidden = false
        } else {
            leftbackbutton.isHidden = true
        }
    }
    
    @IBAction func noSeeNotice(_ sender: UIButton) {
        toggle = !toggle
        toggleButton.image = toggle ? images[0] : images[1]
    }
    
    @IBAction func backBu(_ sender: UIButton) {
        
        self.webView.goBack()
    }
    
    
}
