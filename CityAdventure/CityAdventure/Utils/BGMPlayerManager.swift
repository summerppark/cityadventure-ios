//
//  BGMPlayerManager.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 1..
//  Copyright © 2018년 bubu. All rights reserved.
//

import Foundation
import AVFoundation

class BGMPlayerManager {
    static let shared = BGMPlayerManager()
    var audioPlayer = AVAudioPlayer()
   
    public func bgmStart() {
        play(nameSound: "end_bgm_loop")
    }
    
    public func bgmStop() {
        audioPlayer.stop()
    }
    
    private func play(nameSound:String) {
        // Do any additional setup after loading the view, typically from a nib.
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nameSound, ofType: "mp3")!) )
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        }
        catch{
            print(error)
        }
    }
    
    
}
