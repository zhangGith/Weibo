//
//  ZCPresentationController.swift
//  WBDemo
//
//  Created by Block on 2019/12/29.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class ZCPresentationController: UIPresentationController {
    // 保存菜单的尺寸
    var presentFrame = CGRect.zero

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = presentFrame
        
        containerView?.insertSubview(coverBtn, at: 0)
        coverBtn.addTarget(self, action: #selector(coverClick(btn:)), for: .touchUpInside)

    }
    
    @objc private func coverClick(btn: UIButton) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    private lazy var coverBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.frame = UIScreen.main.bounds
        return btn
    }()
}
