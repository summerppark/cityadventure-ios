//
//  TermsOfUseViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class TermsOfUseViewController: BaseViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutCheck()
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    @IBAction func tappedBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TermsOfUseViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "GodoM", size: 15)!
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var str = ""
        if indexPath.row == 0 {
            str = "이용약관"
        } else if indexPath.row == 1 {
            str = "위치기반 서비스 이용약관"
        } else if indexPath.row == 2 {
            str = "개인정보 처리방침"
        } else if indexPath.row == 3 {
            str = "Open Source Software(OSS)"
        }
        
        
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            if let detail = storyboard?.instantiateViewController(withIdentifier: "TermsOfUseDetailViewController") as? TermsOfUseDetailViewController {
                detail.titleString = str
                detail.index = indexPath.row
                self.navigationController?.pushViewController(detail, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "    약관 및 정책" : "    회사 소개"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            cell.textLabel?.text = "이용약관"
        case (0,1):
            cell.textLabel?.text = "위치기반 서비스 이용약관"
        case (0,2):
            cell.textLabel?.text = "개인정보 처리방침"
        case (0,3):
            cell.textLabel?.text = "Open Source Software(OSS)"
        case (1,0):
            cell.textLabel?.text = "상  호 : (주)비유비유"
        case (1,1):
            cell.textLabel?.text = "대  표 : 유진현"
        case (1,2):
            cell.textLabel?.text = "주  소 : 서울시 마포구 상암로 330, B동 808호"
        case (1,3):
            cell.textLabel?.text = "연 락 처 : 02-304-3352"
        case(1,4):
            cell.textLabel?.text = "이 메 일 : info@bubuok.com"
        default:
            break
            
        }
        
        if indexPath.section == 1 {
            cell.accessoryType = .none
            cell.selectionStyle = .none
        }
        
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont(name: "GodoM", size: 14.0)
        
        return cell
    }
}
