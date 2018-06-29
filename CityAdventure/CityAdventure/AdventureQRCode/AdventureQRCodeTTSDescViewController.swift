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
            playerSlider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var cityTitle: UILabel!
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.font = UIFont(name: "GodoM", size: 18.0)
        }
    }
    
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.addTarget(self, action: #selector(audioBox(sender:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var stopButton: UIButton! {
        didSet {
            stopButton.addTarget(self, action: #selector(audioBox(sender:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var replayButton: UIButton! {
        didSet {
            replayButton.addTarget(self, action: #selector(audioBox(sender:)), for: .touchUpInside)
        }
    }
    
    var player: AVPlayer?
    var playerItem : AVPlayerItem?
    var cityNumber: String = ""
    var cityTitleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        dataSet(text: cityNumber)
        
    }
    
    func dataSet(text: String) {
        
        //Slider
        playerSlider.setValue(0.0, animated: false)
         cityTitle.text = cityTitleString
        let index = Int(text) ?? 0
        // TextView
        textView.attributedText = DataManager.shared.cityCards[index-1].t_cityExplain.convertHtml()
        textView.font = UIFont(name: "GodoM", size: 18.0)
        DispatchQueue.main.async { [weak self] in
            // Sound
            self?.loadRadio(radioURL: APIUrls.getKanjiExpMp3Loading(index: text, type: "3"))
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func handleSliderChange() {
        print(playerSlider.value, "valuie")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player?.pause()
        player = nil
        
    }
    
    @objc func audioBox(sender: UIButton) {
        print(sender.tag, " 버튼 20, 30, 40")
        switch sender.tag {
        case 20:
            player?.play()
        case 30:
            player?.pause()
        case 40:
            loadRadio(radioURL: APIUrls.getKanjiExpMp3Loading(index: cityNumber, type: "3"))
        default:
            break
        }
    }
    
    func loadRadio(radioURL: String) {
        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        self.playerItem = playerItem
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()

        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (time) in
            
            let seconds = CMTimeGetSeconds(time)
            if let duration = self.player?.currentItem?.duration {
                let durationSec = CMTimeGetSeconds(duration)
               
                self.playerSlider.value = Float(seconds / durationSec)
            }
        })
    }
}
