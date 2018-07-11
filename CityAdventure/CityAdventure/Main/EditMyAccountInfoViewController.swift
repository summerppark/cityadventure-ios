//
//  EditMyAccountInfoViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 11..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Toaster
import Alamofire

class EditMyAccountInfoViewController: BaseViewController {
    
    
    // 헤더뷰
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    let nextOn = UIImage(named: "btn_next_On")
    let nextOff = UIImage(named: "btn_next")
    
    var toggles: [Bool] = [false, false, false, false, false]
    
    
    // 저장 시킬 항목 변수
    var savedBirthday: String = ""
    var gender: String = ""
    
    
    // 이름 텍스트필드
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.attributedPlaceholder = NSAttributedString(string: nameTextField.placeholder!, attributes: (attributedString as Any as! [NSAttributedStringKey : Any]))
        }
    }
    
    // 남자
    @IBOutlet weak var maleCheckImage: UIImageView!
    @IBOutlet weak var maleButton: UIButton! {
        didSet {
            maleButton.addTarget(self, action: #selector(genderSelect), for: .touchUpInside)
        }
    }
    
    // 여자
    @IBOutlet weak var femaleCheckImage: UIImageView!
    @IBOutlet weak var femaleButton: UIButton! {
        didSet {
            femaleButton.addTarget(self, action: #selector(genderSelect), for: .touchUpInside)
        }
    }
    
    // 생일 텍스트 필드 -> 데이트피커
    @IBOutlet weak var birthdayTextField: UITextField! {
        didSet {
            birthdayTextField.attributedPlaceholder = NSAttributedString(string: birthdayTextField.placeholder!, attributes: (attributedString as Any as! [NSAttributedStringKey : Any]))
        }
    }
    
    // 데이트피커
    let picker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = UIColor.lightBrownBgColor
        return dp
    }()
    
    // 삭제버튼
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.addTarget(self, action: #selector(deleteName), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var bornCityButton: UIButton! {
        didSet {
            bornCityButton.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var currentLiveCityButton: UIButton! {
        didSet {
            currentLiveCityButton.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    // City 입력 컨스트레인트
    @IBOutlet weak var cityTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityHeight: NSLayoutConstraint!
    @IBOutlet weak var cityLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bornTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var livedCityTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    

    let checkOn = UIImage(named: "btn_checkOn_gender")
    let checkOff = UIImage(named: "btn_check_gender")
    
    let checkedAttributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 18.0),
                                    NSAttributedStringKey.foregroundColor : UIColor.black
    ]
    
    let attributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 13.0),
                             NSAttributedStringKey.foregroundColor : UIColor.buttonTitleColor
    ]
    
    
    var editedName: String = ""
    var editedGender: Bool = true
    var editedBirth: String = ""
    var editedBornCity: String = ""
    var editedCurrentCity: String = ""
    var editedGenderString: String = ""
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCheck()
        createDatePicker()
        addGesture()
        setData()
        
        cityDataSet()
        
    }
    
    func cityDataSet() {
        
        if let city = DataManager.shared.userInfo?.userInfo,
            let homeProvince = city.ui_homeProvince,
            let homeCity = city.ui_homeCity,
            let livingProvince = city.ui_livingProvince,
            let livingCity = city.ui_livingCity {
            
            UserDefaults.standard.set(homeProvince, forKey: "signup_homeProvince")
            UserDefaults.standard.set(homeCity, forKey: "signup_homeNumber")
            UserDefaults.standard.set(livingProvince, forKey: "signup_livingProvince")
            UserDefaults.standard.set(livingCity, forKey: "signup_livingNumber")
        }
        
        
        
    }
    
    func setData() {
        
        
        self.birthdayTextField.text = editedBirth
        self.nameTextField.text = editedName
        makeAttributedString(toggle: editedGender)
        if editedGender {
            editedGenderString = "m"
            gender = "m"
        } else {
            editedGenderString = "f"
            gender = "f"
        }
        selectedCity(name: editedBornCity, tag: 0)
        selectedCity(name: editedCurrentCity, tag: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePressed))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // 성별 누를때 마다
    @objc func genderSelect(sender: UIButton) {
        
        toggles[1] = true
        if sender.tag == 0 {
            gender = "m"
            makeAttributedString(toggle: true)
        } else {
            gender = "f"
            makeAttributedString(toggle: false)
        }
        checkEdited()
    }
    
    
    
    // X 버튼 눌렀을 때
    @objc func deleteName() {
        nameTextField.text = ""
    }
    
    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            headerViewHeight.constant = 88
        }
        if Constants.DeviceType.IS_IPHONE_6P || Constants.DeviceType.IS_IPHONE_X {
            cityTopConstraint.constant = 42
            cityHeight.constant = 260
            cityLabelTopConstraint.constant = 12
            // 밑에 도시부분
            bornTopConstraint.constant = 28
            livedCityTopConstraint.constant = 18
            labelTopConstraint.constant = 12
        }
    }
    
    
    
    // 성별 선택 로직
    func makeAttributedString(toggle: Bool) {
        // 남자가 true 여자가 false
        maleCheckImage.image = toggle ? checkOn : checkOff
        femaleCheckImage.image = !toggle ? checkOn : checkOff
        let type = toggle ? checkedAttributedString : attributedString
        let type2 = toggle ? attributedString : checkedAttributedString
        maleButton.setAttributedTitle(NSAttributedString(string: (maleButton.titleLabel?.text)!, attributes: type as Any as? [NSAttributedStringKey : Any]), for: .normal)
        femaleButton.setAttributedTitle(NSAttributedString(string: (femaleButton.titleLabel?.text)!, attributes: (type2 as Any as? [NSAttributedStringKey : Any])), for: .normal)
    }
    
    func checkEdited() {
        guard let nametf = nameTextField.text, let birth = self.birthdayTextField.text, let born = self.bornCityButton.currentTitle, let current = self.currentLiveCityButton.currentTitle else {
            
            nextButton.isEnabled = false
            return
        }
        
        if editedName == nametf && editedBirth == birth && editedBornCity == born && editedCurrentCity == current && editedGenderString == gender {
            nextButton.isEnabled = false
            print("수정내용 없음")
        } else {
            // 수정로직
            print("수정내용 있음")
            nextButton.isEnabled = true
        }
    }
    
    // 뒤로가기
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 다음으로
    @IBAction func goToNext(_ sender: Any) {
        super.showLoading(view: self.view)
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            Toast.init(text: "다시 시도해주세요").show()
            return
        }
        
        guard let member = DataManager.shared.userInfo?.userInfo?.no else {
            Toast.init(text: "다시 시도해주세요").show()
            return
        }
        
        //urlQuery
        guard let name = self.nameTextField.text else {
            Toast.init(text: "다시 시도해주세요").show()
            return
        }
        
        guard let homeCity = UserDefaults.standard.object(forKey: "signup_homeNumber") as? Int32 else {
            return
        }
        
        guard let homeProvince = UserDefaults.standard.object(forKey: "signup_homeProvince") as? Int32 else {
            return
        }
        guard let livingProvince = UserDefaults.standard.object(forKey: "signup_livingProvince") as? Int32 else {
            return
        }
        guard let livingCity = UserDefaults.standard.object(forKey: "signup_livingNumber") as? Int32 else {
            return
        }
        
        guard let birth = self.birthdayTextField.text else {
            return
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        // 선택 값 넣어주기.
        birthdayTextField.text = dateFormatter.string(from: picker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print("EditInfo", token,member,name,homeCity,homeProvince,livingCity,livingProvince,dateFormatter.string(from: picker.date), editedGenderString, gender)
        
        print("===>", APIUrls.getEditMyInfo(token: token, memberNumber: member, homeProvince: homeProvince, homeCity: homeCity, livingProvince: livingProvince, livingCity: livingCity, name: name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", gender: gender, birth: dateFormatter.string(from: picker.date)))
        
        
        
        Alamofire.request(APIUrls.getEditMyInfo(token: token, memberNumber: member, homeProvince: homeProvince, homeCity: homeCity, livingProvince: livingProvince, livingCity: livingCity, name: name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", gender: gender, birth: dateFormatter.string(from: picker.date)), method: .put, parameters: nil, encoding: JSONEncoding.default).responseObject { (response : DataResponse<NewBaseResponse>) in
            switch response.result {
            case .success:
                if let userInfo = DataManager.shared.userInfo?.userInfo {
                    userInfo.c_gender = self.gender
                    userInfo.date_birth = dateFormatter.string(from: self.picker.date)
                    userInfo.ui_homeCity = Int(homeCity)
                    userInfo.ui_homeProvince = Int(homeProvince)
                    userInfo.ui_livingCity = Int(livingCity)
                    userInfo.ui_livingProvince = Int(livingProvince)
                    userInfo.s_name = name
                }
                
                super.hideLoading()
                if let alert = self.storyboard?.instantiateViewController(withIdentifier: "AlertviewController") as? AlertviewController {
                    alert.delegate = self
                    alert.modalPresentationStyle = .overCurrentContext
                    alert.alertString = "정보가 성공적으로 수정되었습니다."
                    self.present(alert, animated: false, completion: nil)
                }
                
                
            case .failure(let error):
                print("실1패", error.localizedDescription)
                super.hideLoading()
                Toast.init(text: "정보 수정에 실패하였습니다.").show()
            }
        }
    }
    
    
    // 데이트피커 생성
    func createDatePicker() {
        //Toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.top_Brown_Color
        
        let term = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let setting = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(donePressed))
        
        
        let checkedAttributedString = [ NSAttributedStringKey.font : UIFont(name: "GodoM", size: 18.0),
                                        NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        
        
        // 설정 글씨 스타일 변경
        setting.setTitleTextAttributes(checkedAttributedString as Any as? [NSAttributedStringKey : Any], for: .normal)
        //닫기 글씨 스타일 변경
        let close = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closePressed))
        
        close.setTitleTextAttributes(checkedAttributedString as Any as? [NSAttributedStringKey : Any], for: .normal)
        toolBar.setItems([term,close,term,setting,term], animated: false)
        
        birthdayTextField.inputAccessoryView = toolBar
        birthdayTextField.inputView = picker
        
        picker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        if let date = dateFormatter.date(from: editedBirth) {
            picker.setDate(date, animated: true)
        }
        
        
    }
    
    // 선택
    @objc func donePressed() {
        toggles[2] = true
        // 데이트 형식 셋팅
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        // 선택 값 넣어주기.
        birthdayTextField.text = dateFormatter.string(from: picker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        savedBirthday = dateFormatter.string(from: picker.date)
        checkStatus()
        checkEdited()
        self.view.endEditing(true)
    }
    
    // 닫기
    @objc func closePressed() {
        self.view.endEditing(true)
    }
    
    // 도시 선택하기
    @objc func selectCity(sender: UIButton) {
        var str = ""
        if sender.tag == 0 {
            str = "태어난 고향을 입력하세요!"
        } else {
            str = "살고 있는 도시를 입력하세요!"
        }
        
        if let selectCityVC = storyboard?.instantiateViewController(withIdentifier: "SelectCityViewController") as? SelectCityViewController {
            selectCityVC.titleString = str
            selectCityVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            selectCityVC.modalPresentationStyle = .overFullScreen
            selectCityVC.delegate = self
            self.present(selectCityVC, animated: false, completion: nil)
        }
    }
    
    func checkStatus() {
        if toggles[0] && toggles[1] && toggles[2] && toggles[3] && toggles[4] {
//            nextButton.setImage(nextOn, for: .normal)
//            nextButton.isEnabled = true
        } else {
//            nextButton.setImage(nextOff, for: .normal)
//            nextButton.isEnabled = false
        }
    }
}


extension EditMyAccountInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            deleteButton.isHidden = false
        }
    }
    
    // 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.resignFirstResponder()
        }
        checkEdited()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            toggles[0] = !(textField.text == "")
            checkStatus()
            checkEdited()
            deleteButton.isHidden = true
        }
        checkEdited()
        return true
    }
    
    // nameTextField 만 4자리까지 입력 가능하도록 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            let newLength = (textField.text?.count)! + string.count - range.length
            return !(newLength > 4)
        }
        return true
    }
}



extension EditMyAccountInfoViewController: SelectCityProtocol {
    func selectedCity(name: String, tag: Int) {
        print(name,tag)
        if tag == 0 {
            toggles[3] = true
            bornCityButton.setTitleColor(.black, for: .normal)
            bornCityButton.setTitle(name, for: .normal)
            checkStatus()
            checkEdited()
        } else {
            toggles[4] = true
            currentLiveCityButton.setTitleColor(.black, for: .normal)
            currentLiveCityButton.setTitle(name, for: .normal)
            checkStatus()
            checkEdited()
        }
    }
}


extension EditMyAccountInfoViewController: AlertViewProtocol {
    func successAuth() {
        
    }
    
    func successCallback() {
        
    }
    
    func successEdit() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
