//
//  AdventureQRCodeTTSDescViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 6. 15..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import AVFoundation

class AdventureQRCodeTTSDescViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 8.0
            mainView.layer.borderWidth = 8.0
            mainView.layer.borderColor = UIColor().colorFromHex("#ff4863").cgColor
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var playerInfoView: UIView! {
        didSet {
            playerInfoView.layer.cornerRadius = 8.0
            playerInfoView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var playerSlider: UISlider! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var cityTitle: UILabel!
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.font = UIFont(name: "GodoM", size: 18.0)
        }
    }
    
    
    var player: AVPlayer?
    var cityNumber: String = ""
    var cityTitleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        dataSet(text: cityNumber)
    }
    
    func dataSet(text: String) {
         cityTitle.text = cityTitleString
        let index = Int(text) ?? 0
        // TextView
        textView.attributedText = DataManager.shared.cityCards[index-1].t_cityExplain.convertHtml()
        textView.font = UIFont(name: "GodoM", size: 18.0)
        
        // Sound
         loadRadio(radioURL: APIUrls.getKanjiExpMp3Loading(index: text, type: "3"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func loadRadio(radioURL: String) {
        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
   
    
}
