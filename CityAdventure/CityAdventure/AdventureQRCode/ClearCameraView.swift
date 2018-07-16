//
//  ClearCameraView.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 16..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import AVFoundation
import Toaster

class ClearCameraView: BaseViewController {
    
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let captureDevice =  AVCaptureDevice.default(for: .video) else { return }
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraStatus {
        case .denied:
//            needPermissionAlert()
            return
        default:
            break
        }
        
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print("Error QRCode Read")
           
        }
        
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}


extension ClearCameraView: AVCaptureMetadataOutputObjectsDelegate {
    
    
    //    QRCode Recognize
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        
        if let object = metadataObjects.first {
            if object.type == .qr {
                print("QR성공",(object as? AVMetadataMachineReadableCodeObject)?.stringValue)
                
                self.dismiss(animated: true, completion: {
                    Toast.init(text: "정상적으로 인식되었습니다.", delay: 0.0, duration: 0.25).show()
                })
                session.stopRunning()
                session.removeOutput(output)
                return
            } else {
                // 인식 안되었을 때
            }
        }
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "도시탐험대", message: "정상적으로 인식 되었습니다.", preferredStyle: .alert)
        
        let okbutton = UIAlertAction(title: "확인", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okbutton)
        self.present(alertController, animated: true, completion: nil)
        
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
    
    func needPermissionAlert() {
        let alertController = UIAlertController(title: "카메라 이용 권한 없음",
                                                message: "도시를 탐험하기 위하여 카메라 이용 권한이 필요합니다.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "설정으로 이동", style: .destructive) { (action) in
            guard let url = URL(string:UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.open(url)
        })
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

