//
//  AdventureQRCodeReaderViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 5. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import AVFoundation

class AdventureQRCodeReaderViewController: UIViewController {
  
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!
    
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?

    @IBOutlet weak var checkRecognizeView: UIView!
    @IBOutlet weak var animationView: UIView!
 
    
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeFlipViewController") as? AdventureQRCodeFlipViewController {
            result.cityNumber = "수원"
//            if let stringValue = (object as? AVMetadataMachineReadableCodeObject)?.stringValue {
//                result.cityNumber = stringValue
//            }
            self.navigationController?.pushViewController(result, animated: true)
        }
        
        guard let captureDevice =  AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print("Error QRCode Read")
            shakeView(vw: checkRecognizeView)
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
        
       
        // Get the back-facing camera for capturing videos
        // Move the message label and top bar to the front
        view.bringSubview(toFront: messageLabel)
        view.bringSubview(toFront: topbar)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("QRCode", session.isRunning)
        // Animation
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut, .repeat], animations: {
            [weak self] in
            self?.animationView.frame.origin.y -= 50
        }) { (action) in
            print("핸들러")
        }
    }
    
    // MARK: - Helper methods
    
    
    // 인식 확인 흔들리는 애니메이션
    func shakeView(vw: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        
        vw.layer.add(animation, forKey: "shake")
    }
    
    
    @IBAction func presentAlertView(_ sender: Any) {
        if let alert = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeCheckPopup") as? AdventureQRCodeCheckPopup {
            alert.modalPresentationStyle = .overFullScreen
            alert.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.present(alert, animated: false)
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openShoppingMall(_ sender: UIButton) {
        if let url = URL(string: "http://naver.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}


extension AdventureQRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
//    QRCode Recognize
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
   
        if let object = metadataObjects.first {
            if object.type == .qr {
                print("QR성공",(object as? AVMetadataMachineReadableCodeObject)?.stringValue)
                session.stopRunning()
                if let result = storyboard?.instantiateViewController(withIdentifier: "AdventureQRCodeFlipViewController") as? AdventureQRCodeFlipViewController {
                    
                    if let stringValue = (object as? AVMetadataMachineReadableCodeObject)?.stringValue {
                        result.cityNumber = stringValue
                    }
                    self.navigationController?.pushViewController(result, animated: true)
                    return
                } else {
                    // 인식 안되었을 때
                    shakeView(vw: checkRecognizeView)
                }
            }
        }
    }
    
    
    private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
        layer.videoOrientation = orientation
        videoPreviewLayer?.frame = self.view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let connection =  self.videoPreviewLayer?.connection  {
            
            let currentDevice: UIDevice = UIDevice.current
            
            let orientation: UIDeviceOrientation = currentDevice.orientation
            
            let previewLayerConnection : AVCaptureConnection = connection
            
            if previewLayerConnection.isVideoOrientationSupported {
                
                switch (orientation) {
                case .portrait: updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                
                    break
                    
                case .landscapeRight: updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                
                    break
                    
                case .landscapeLeft: updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                
                    break
                    
                case .portraitUpsideDown: updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                
                    break
                    
                default: updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                
                    break
                }
            }
        }
    }
}

