//
//  AdventureQRCodeTextSoundViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 14..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import AVFoundation

class AdventureQRCodeTextSoundViewController: BaseViewController {
    
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor().colorFromHex("#fcf5d3")
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var chinaTextView: UIView! {
        didSet {
            chinaTextView.layer.cornerRadius = 8.0
            chinaTextView.layer.borderWidth = 2.0
            chinaTextView.layer.borderColor = UIColor().colorFromHex("#e3d8a4").cgColor
        }
    }
    
    
    @IBOutlet weak var koreaTextView: UIView! {
        didSet {
            koreaTextView.layer.cornerRadius = 8.0
            koreaTextView.layer.borderWidth = 2.0
            koreaTextView.layer.borderColor = UIColor().colorFromHex("#e3d8a4").cgColor
        }
    }
    
    
    
    
    @IBOutlet weak var twoWordBottomView: UIView!
    @IBOutlet weak var twoWordUpView: UIView!
    
    
    
    
    @IBOutlet weak var firstKanji: UILabel!
    @IBOutlet weak var secondKanji: UILabel!
    @IBOutlet weak var firstKanjiExp: UILabel!
    @IBOutlet weak var secondKanjiExp: UILabel!
    
    @IBOutlet weak var firstCityname: UILabel!
    @IBOutlet weak var secondCityname: UILabel!
    
    
    
    
    
    @IBOutlet weak var threeWordBottomView: UIView!
    @IBOutlet weak var threeWordUpView: UIView!
    
    @IBOutlet weak var oneKanjiExp: UILabel!
    @IBOutlet weak var twoKanjiExp: UILabel!
    @IBOutlet weak var threeKanjiExp: UILabel!
    
    
    @IBOutlet weak var oneKanji: UILabel!
    @IBOutlet weak var twoKanji: UILabel!
    @IBOutlet weak var threeKanji: UILabel!
    
    
    @IBOutlet weak var threeCityName: UILabel!
    
    
    
    
    var player: AVPlayer?
    var strArray: [String] = []
    var number: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        
        dataSet(count: Int(strArray[3].count))
        
    }
    
    func dataSet(count: Int) {
        print(count)
        if count == 2 {
            threeWordUpView.isHidden = true
            threeWordBottomView.isHidden = true
            twoWordUpView.isHidden = false
            twoWordBottomView.isHidden = false
            print("!@!@",strArray[2])
            firstKanji.text = String(describing: strArray[2].first!)
            secondKanji.text = String(describing: strArray[2].last!)
            firstKanjiExp.text = strArray[0]
            secondKanjiExp.text = String(strArray[1].dropFirst())
            firstCityname.text = String(describing: strArray[3].first!)
            secondCityname.text = String(describing: strArray[3].last!)
        } else {
            
            print(strArray)
            threeWordUpView.isHidden = false
            threeWordBottomView.isHidden = false
            twoWordUpView.isHidden = true
            twoWordBottomView.isHidden = true
            
            var kanjis: [String] = []
            strArray[3].forEach({ (char) in
                kanjis.append(String(char))
            })
            
            oneKanji.text = kanjis[0]
            twoKanji.text = kanjis[1]
            threeKanji.text = kanjis[2]
            
            kanjis.removeAll()
            strArray[1].forEach({ (char) in
                kanjis.append(String(char))
            })
            
            oneKanjiExp.text = strArray[0]
            twoKanjiExp.text = strArray[1]
            threeKanjiExp.text = strArray[2]
            threeCityName.text = strArray[4]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false , completion: nil)
    }
    
    @IBAction func soundplay(_ sender: UIButton) {
        
        sender.setImage(#imageLiteral(resourceName: "btn_replay"), for: .normal)
        
        if sender.tag == 15 {
            loadRadio(radioURL: APIUrls.getKanjiExpMp3Loading(index: number, type: "2"))
            //위에
        } else {
            loadRadio(radioURL: APIUrls.getKanjiExpMp3Loading(index: number, type: "1"))
        }
    }
    
    func loadRadio(radioURL: String) {
        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
    
}

