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
    
    // 도시 정보
    var citynumbers: [CityNumbersDB] = []
    var searchedCity: [CityNumbersDB] = []
    
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
        
        // DB에있는 도시정보를 가져옴
        connectDatabase()
        
    }
    
    // db 검색
    func findCity(inputText: String) {
        searchedCity.removeAll()
        // 빈 문자열이면 전체리스트를 보여준다.
        guard inputText != "" else {
            searchedCity = citynumbers
            tableView.reloadData()
            return
        }
        
        // 검색 된 결과만 보여준다.
        for index in 0...citynumbers.count-1 {
            if citynumbers[index].cityName.contains(inputText) {
                print(citynumbers[index].cityName, inputText)
                searchedCity.append(citynumbers[index])
            }
        }
        //검색 결과 갱신
        tableView.reloadData()
    }
    
    
    
    // db 데이타 긁어오기.
    func connectDatabase() {
        let db = Bundle.main.path(forResource: "cityNumber", ofType: "sqlite")
        let path = FMDatabase(path: db)
        
        if path.open() {
            let fetchData = "SELECT * FROM cityNumber"
            guard let results: FMResultSet = path.executeQuery(fetchData, withArgumentsIn: []) else { return }
           
            while results.next() == true {
               let cityInfo = CityNumbersDB.init(number: results.int(forColumn: "no"),
                                   cityName: results.string(forColumn: "s_name") ?? "",
                                   cityType: results.string(forColumn: "s_type") ?? "",
                                   provinceType: results.int(forColumn: "ui_province"),
                                   areaName: results.string(forColumn: "s_area") ?? "")
                citynumbers.append(cityInfo)
            }
            searchedCity = citynumbers
        }
        
        path.close()
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
    
    // 서치 텍스트필드 값이 변경될때마다 호출, 검색을 시도 , 검색할 때마다 검색로직을 실행시킨다.
    @objc func textFieldDidChange(sender: UITextField) {
        findCity(inputText: sender.text ?? "")
    }
}



extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    // 몇개리스트를 보여줄것인가.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCity.count
    }
    
    // 테이블 뷰 데이터를 뿌려줌
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityTableViewCell", for: indexPath) as! SearchCityTableViewCell
        let city = searchedCity[indexPath.row]
        cell.cityLabel.text =  city.areaName + " " + city.cityName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 탭했을 때
        let city = searchedCity[indexPath.row]
        
        if tag == 0 {
            UserDefaults.standard.set(city.provinceType, forKey: "signup_homeProvince")
            UserDefaults.standard.set(city.number, forKey: "signup_homeNumber")
        } else {
            UserDefaults.standard.set(city.provinceType, forKey: "signup_livingProvince")
            UserDefaults.standard.set(city.number, forKey: "signup_livingNumber")
        }
        
        
        let selectedCity = city.areaName + " " + city.cityName
        delegate?.selectedCity(name: selectedCity, tag: tag)
        self.dismiss(animated: false)
    }
 
}
