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
        previewLayer.frame = view.frame
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
    }
    
    // MARK: - lazy
    
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        return try? AVCaptureDeviceInput(device: device!)
    }()
    
    private lazy var session: AVCaptureSession = AVCaptureSession()
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
    
}

extension QRCodeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        containerHeightCons.constant = (item.tag == 1) ? 150 : 300
        view.layoutIfNeeded()
        scanLineView.layer.removeAllAnimations()
        
        startAnimation()
    }
}


extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let obj: AVMetadataMachineReadableCodeObject = metadataObjects.last as! AVMetadataMachineReadableCodeObject
        customLab.text = obj.stringValue ?? ""
    }
}
