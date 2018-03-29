//
//  SignUpViewThirdController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 3. 28..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class SignupViewThirdController: UIViewController {
    
    var selectCityViewController: SelectCityViewController?
    
    
    // 헤더뷰
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        layoutCheck()
        createDatePicker()
    }
    
    
    // 성별 누를때 마다
    @objc func genderSelect(sender: UIButton) {
        if sender.tag == 0 {
            makeAttributedString(toggle: true)
        } else {
            makeAttributedString(toggle: false)
        }
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
        maleCheckImage.image = toggle ? checkOn : checkOff
        femaleCheckImage.image = !toggle ? checkOn : checkOff
        let type = toggle ? checkedAttributedString : attributedString
        let type2 = toggle ? attributedString : checkedAttributedString
        maleButton.setAttributedTitle(NSAttributedString(string: (maleButton.titleLabel?.text)!, attributes: type as Any as? [NSAttributedStringKey : Any]), for: .normal)
        femaleButton.setAttributedTitle(NSAttributedString(string: (femaleButton.titleLabel?.text)!, attributes: (type2 as Any as? [NSAttributedStringKey : Any])), for: .normal)
    }
    
    // 뒤로가기
    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    }
    
    // 선택
    @objc func donePressed() {
        // 데이트 형식 셋팅
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        // 선택 값 넣어주기.
        birthdayTextField.text = dateFormatter.string(from: picker.date)
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
}


extension SignupViewThirdController: UITextFieldDelegate {
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
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            deleteButton.isHidden = true
        }
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



extension SignupViewThirdController: SelectCityProtocol {
    func selectedCity(name: String, tag: Int) {
        print(name,tag)
        if tag == 0 {
            bornCityButton.setTitleColor(.black, for: .normal)
            bornCityButton.setTitle(name, for: .normal)
        } else {
            currentLiveCityButton.setTitleColor(.black, for: .normal)
            currentLiveCityButton.setTitle(name, for: .normal)
        }
    }
    
    
    
    
}
