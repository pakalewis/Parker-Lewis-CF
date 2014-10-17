//
//  AVFoundationCameraVC.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/16/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import CoreVideo
import ImageIO
import QuartzCore

class AVFoundationCameraVC: UIViewController {

    @IBOutlet weak var capturePreviewImageView: UIImageView!
    
    var delegate : ImageSelectedProtocol?
    
    var stillImageOutput = AVCaptureStillImageOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.capturePreviewImageView.image = UIImage(named: "default_image")
//        var captureSession = AVCaptureSession()
//        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
//        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = CGRectMake(0, 64, self.view.frame.size.width, CGFloat(self.view.frame.size.height * 0.6))
//        self.view.layer.addSublayer(previewLayer)
//        
//        var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
//        var error : NSError?
//        var input = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as AVCaptureDeviceInput!
//        if input == nil {
//            println("bad!")
//        }
//        captureSession.addInput(input)
//        var outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
//        self.stillImageOutput.outputSettings = outputSettings
//        captureSession.addOutput(self.stillImageOutput)
//        captureSession.startRunning()
    }
    
    
    @IBAction func captureButtonPressed(sender: AnyObject) {
        
        println("button pressed")
//        var videoConnection : AVCaptureConnection?
//        for connection in self.stillImageOutput.connections {
//            if let cameraConnection = connection as? AVCaptureConnection {
//                for port in cameraConnection.inputPorts {
//                    if let videoPort = port as? AVCaptureInputPort {
//                        if videoPort.mediaType == AVMediaTypeVideo {
//                            videoConnection = cameraConnection
//                            break;
//                        }
//                    }
//                }
//            }
//            if videoConnection != nil {
//                break;
//            }
//        }
//
//        self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(buffer : CMSampleBuffer!, error : NSError!) -> Void in
//            var data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
//            var image = UIImage(data: data)
//            self.capturePreviewImageView.image = image
//        })
    }
}
