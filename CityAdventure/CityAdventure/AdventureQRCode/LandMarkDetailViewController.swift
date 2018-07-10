//
//  LandMarkDetailViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 4..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import Alamofire
import Toaster


class LandMarkDetailViewController: BaseViewController {

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var landmarkTableView: UITableView! {
        didSet {
            landmarkTableView.delegate = self
            landmarkTableView.dataSource = self
        }
    }
    
    
    @IBOutlet weak var landmarkName: UILabel!
    @IBOutlet weak var landmarkDesc: UITextView! {
        didSet {
            landmarkDesc.font = UIFont.init(name: "GodoM", size: 16.0)
        }
    }
    
    @IBOutlet weak var lm_firstImage: UIImageView!
    @IBOutlet weak var photoSliderView: UIScrollView!
    
    var landmarkNumber: Int = 1
    var landmarkImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.showLoading(view: self.view)
        
        if let image = landmarkImage {
            self.lm_firstImage.image = image
        }
        // bubu API
        
        Alamofire.request(APIUrls.getLandmarkDetail(number: landmarkNumber), method: .get, parameters: nil, encoding: JSONEncoding.default).responseObject { (response: DataResponse<LandmarkDetail>) in
            print("=====>", response.result.value)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    // 성공
                    self.dataSetting(inputData: result)
                }
            case .failure:
                Toast.init(text: "다시 시도해주세요").show()
            }
            super.hideLoading()
        }
        
        
        
        layoutcheck()
        print("landmarkNumber", landmarkNumber)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func layoutcheck() {
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88.0
        }
    }
    
    
    func dataSetting(inputData: LandmarkDetail) {
        guard let landmark = inputData.detailData else { return }
        // 내용
        landmarkDesc.text = landmark.t_description
        
        // title
        landmarkName.text = landmark.s_name
        
        
    }

    
    @IBAction func tappedBackbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension LandMarkDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 네이버 블로그 검색 결과갯수만큼
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkSearchCell") as! LandmarkSearchCell
        if indexPath.row == 0 {
            cell.tempImage.isHidden = false
        } else {
            cell.tempImage.isHidden = true
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
        
    }
    
}
