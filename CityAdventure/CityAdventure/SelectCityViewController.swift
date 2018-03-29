//
//  SelectCityViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 29..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import SnapKit

protocol SelectCityProtocol: class {
    func selectedCity(name: String, tag: Int)
}

class SelectCityViewController: UIViewController {
    
    var delegate: SelectCityProtocol?
    var tag: Int = 0
    
    // 검색 텍스트필드
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        }
    }
    
    // 검색결과 테이블 뷰
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    // 제목 레이블 설정
    var titleString: String?
    
    //검색 + 결과 담고있는 뷰
    @IBOutlet weak var cityView: UIView! {
        didSet {
            cityView.layer.borderWidth = 5.0
            cityView.layer.borderColor = UIColor.ultraLightGray.cgColor
        }
    }
    
    // 제목
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    // 높이
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButtonLayout()
        layoutCheck()
        
        // 태어난 곳인지 사는 곳인지
        tag = titleString?.first == "태" ? 0 : 1
        
    }
    
    // X버튼 레이아웃
    func closeButtonLayout() {
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImageView.snp.trailing).offset(-4)
            make.centerY.equalTo(bgImageView.snp.top).offset(4)
            make.width.height.equalTo(38)
        }
    }
    
    // 디바이스 별 레이아웃 체크
    func layoutCheck() {
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            heightConstraint.constant = 400
            
        }
    }
    
    @IBAction func closeSelectCity(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK:- 검색부분
    @IBAction func tappedSearchButton(_ sender: Any) {
        // 검색 시작
        print("검색",searchTextField.text ?? "")
    }
    
}



extension SelectCityViewController: UITextFieldDelegate
{
    // 서치 텍스트필드 값이 변경될때마다 호출, 검색을 시도
    
    @objc func textFieldDidChange(sender: UITextField) {
            print(sender.text ?? "" )
    }
}



extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    // 몇개리스트를 보여줄것인가.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // 테이블 뷰 데이터를 뿌려줌
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityTableViewCell", for: indexPath) as! SearchCityTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 탭했을 때
    
        delegate?.selectedCity(name: "강원도 강릉", tag: tag)
        self.dismiss(animated: false)
    }
}
