//
//  ResultCorrectPopUp.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 23..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import UIView_Shake


protocol ResultCorrectPopUpProtocol: class {
    func tappedBGView()
    func tappedNext()
}

class ResultCorrectPopUp: BaseViewController {
    
    
    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.backgroundColor = .clear
        }
    }
    
    var delegate: ResultCorrectPopUpProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        
        centerView.shake(150, withDelta: -4, speed: 0.35, shakeDirection: .vertical)
    }
    
    func addGesture() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(close))
        self.view.addGestureRecognizer(tapgesture)
    }
    
    @objc func close() {
        self.dismiss(animated: false) {
            self.delegate?.tappedBGView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func goToNext(_ sender: UIButton) {
        self.delegate?.tappedNext()
    }
}
