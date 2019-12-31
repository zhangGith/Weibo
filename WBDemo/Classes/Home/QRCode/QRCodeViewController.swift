//
//  QRCodeViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/30.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    @IBOutlet weak var customContainerView: UIView!
    @IBOutlet weak var customTabbar: UITabBar!
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    @IBOutlet weak var scanLineView: UIImageView!
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    @IBOutlet weak var customLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabbar.selectedItem = customTabbar.items?.first
        
        customTabbar.delegate = self
        scanQRCode()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimation()
    }
    
    //MARK: -
    private func scanQRCode() {
        if !session.canAddInput(input!) || !session.canAddOutput(output) {
            return
        }
        
        session.addInput(input!)
        session.addOutput(output)
        
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        session.startRunning()
    }
    
    private func startAnimation() {
        scanLineCons.constant = -containerHeightCons.constant
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineCons.constant = self.containerHeightCons.constant
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func closeClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoClick(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    // MARK: - lazy
    
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device == nil) {return nil}
        return try? AVCaptureDeviceInput(device: device!)
    }()
    
    private lazy var session: AVCaptureSession = AVCaptureSession()
    private lazy var output: AVCaptureMetadataOutput = {
        let out = AVCaptureMetadataOutput()
        let rect = self.view.frame
        let containerRect = self.customContainerView.frame
        let x = containerRect.origin.y / rect.height
        let y = containerRect.origin.x / rect.width
        let width = containerRect.height / rect.height
        let height = containerRect.width / rect.width
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        return out
    }()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
    
    private lazy var containerLayer: CALayer = CALayer()
    
}

extension QRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let ciImage = CIImage(image: image) else {
            return
        }
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyLow])
        guard let results = detector?.features(in: ciImage) else { return }
        for result in results {
            NJLog(message: (result as! CIQRCodeFeature).messageString)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension QRCodeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        containerHeightCons.constant = (item.tag == 1) ? 150 : 300
        view.setNeedsLayout()
        scanLineView.layer.removeAllAnimations()
        
        startAnimation()
    }
}


extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadata = metadataObjects.last else {
            return
        }
        let obj: AVMetadataMachineReadableCodeObject = metadata as! AVMetadataMachineReadableCodeObject
        customLab.text = obj.stringValue ?? ""
        
        clearLayers()
        
        
        let objc = previewLayer.transformedMetadataObject(for: metadata)
        drawLines(objc: objc as! AVMetadataMachineReadableCodeObject)
    }
    
    private func drawLines(objc: AVMetadataMachineReadableCodeObject) {
//        guard let arr = objc.corners as? [CGPoint] else {
//            return
//        }
        
        let arr = objc.corners
        if arr.count == 0 {
            return
        }
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        var point = CGPoint.zero
        var index = 0

        point = arr[index]
        index += 1;
        path.move(to: point)
        
        while index < arr.count {
            print("index = ======= \(index)")
            point = arr[index]
            path.addLine(to: point)
            index += 1
        }
        
        path.close()
        
        layer.path = path.cgPath
        containerLayer.addSublayer(layer)
        
        
    }
    
    private func clearLayers() {
        guard let sublayers = containerLayer.sublayers else {
            return
        }
        
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
    }
}
