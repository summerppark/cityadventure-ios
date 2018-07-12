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
import Kingfisher

class LandMarkDetailViewController: BaseViewController {

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var landmarkTableView: UITableView! {
        didSet {
            landmarkTableView.delegate = self
            landmarkTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var sizeWidthView: NSLayoutConstraint!
    @IBOutlet weak var contentSizeView: UIView!
    
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
    var landmarkImageUrls: [String] = []
    var landmakrImageArray: [UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.showLoading(view: self.view)
        
        if let image = landmarkImage {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            lm_firstImage.isUserInteractionEnabled = true
            lm_firstImage.tag = 0
            lm_firstImage.addGestureRecognizer(tapGesture)
            self.landmakrImageArray.append(lm_firstImage)
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
                super.hideLoading()
                Toast.init(text: "다시 시도해주세요").show()
            }
            
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
        
        DispatchQueue.global().async {
            Alamofire.request(APIUrls.getTourApi(search: landmark.s_name ?? ""), method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                if let success = response.result.value as? NSDictionary,
                    let response = success["response"] as? NSDictionary,
                    let body = response["body"] as? NSDictionary,
                    let items = body["items"] as? NSDictionary
                {
                    if let item = items["item"] as? NSDictionary {
                        if let imageurl = item["firstimage"] as? String {
                            print(imageurl)
                            self.landmarkImageUrls.append(imageurl)
                        }
                    } else if let item2 = items["item"] as? [NSDictionary] {
                        print("사진 여러장일 때")
                        item2.forEach({ (dic) in
                            if let imageurl = dic["firstimage"] as? String {
                                print(imageurl)
                                self.landmarkImageUrls.append(imageurl)
                            }
                        })
                    }
                }
                DispatchQueue.main.async {
                    self.photoSliderView.contentSize = CGSize(width: (120.0*Double(self.landmarkImageUrls.count+1)), height: 120.0)
                    
                    print("SizeCheck",self.photoSliderView.contentSize.width,self.landmarkImageUrls.count+1)
                    
                    if self.landmarkImageUrls.count > 0 {
                         self.addImage(index: self.landmarkImageUrls.count)
                    } else {
                        super.hideLoading()
                    }
                }
            }
        }
    }
    
    func addImage(index: Int) {
        
        for idx in 0...index-1 {
            let originX = Double(idx+1) * 120.0
            let imageView = UIImageView(frame: CGRect(x: originX, y: 0.0, width: 120.0, height: 120.0))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            landmakrImageArray.append(imageView)
            photoSliderView.addSubview(imageView)
            imageView.kf.setImage(with: URL(string: self.landmarkImageUrls[idx]))
            imageView.tag = idx+1
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
            

            super.hideLoading()
        }
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        print(sender.view?.tag)
        
        if let img = self.storyboard?.instantiateViewController(withIdentifier: "LandmarkImageView") as? LandmarkImageView, let tag = sender.view?.tag {
            img.lmImage = landmakrImageArray[tag].image
            self.present(img, animated: true, completion: nil)
        }
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
