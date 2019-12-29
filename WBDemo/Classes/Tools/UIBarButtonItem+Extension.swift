//
//  UIBarButtonItem+Extension.swift
//  WBDemo
//
//  Created by Block on 2019/12/29.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String?, target: AnyObject?, action: Selector) {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: imageName ?? ""), for: .normal)
        btn.setImage(UIImage(named: (imageName ?? "") + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        
        self.init(customView: btn)
    }
}
