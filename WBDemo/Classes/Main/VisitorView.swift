//
//  VisitorView.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/27.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    func setupVisitorInfo(imageName: String?, title: String) {
        titleLab.text = title
        
        guard let name = imageName else {
            startAnimation()
            return
        }
        
        rotationView.isHidden = true
        iconView.image = UIImage(named: name)
    }
    
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        anim.isRemovedOnCompletion = false
        rotationView.layer.add(anim, forKey: nil)
    }
    
    
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.last as! VisitorView
    }

}
