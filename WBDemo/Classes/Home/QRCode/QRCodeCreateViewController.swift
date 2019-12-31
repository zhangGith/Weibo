//
//  QRCodeCreateViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/31.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class QRCodeCreateViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue("2019年12月31天".data(using: .utf8), forKeyPath: "InputMessage")
        guard let ciImage = filter?.outputImage else {
            return
        }
//        imageView.image = UIImage(ciImage: ciImage)
        imageView.image = createNonInterpolatedUIImageFormCIImage(image: ciImage, size: imageView.frame.width)
    }
    
    
    /// 生成高清二维码
    /// - Parameters:
    ///   - image: 需要生成原始图片
    ///   - size: 生成的二维码的宽高
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        
        let width = extent.width * scale
        let height = extent.height * scale
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmap = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        guard let bitmapImage = context.createCGImage(image, from: extent) else { return UIImage() }
        
        bitmap.interpolationQuality = .none
        bitmap.scaleBy(x: scale, y: scale)
        bitmap.draw(bitmapImage, in: extent)
        guard let scaledImage = bitmap.makeImage() else { return UIImage() }
        return UIImage(cgImage: scaledImage)
    }

}
