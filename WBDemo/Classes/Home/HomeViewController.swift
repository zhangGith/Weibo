//
//  HomeViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/27.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

/// 自定转场展现
let ZCPresentationManagerDidPresented = "ZCPresentationManagerDidPresented"
/// 自定义转场消失
let ZCPresentationManagerDidDismissed = "ZCPresentationManagerDismissed"

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupVisitorInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        

        setupNav()
        
        NotificationCenter.default.addObserver(self, selector: #selector(titleChange), name: NSNotification.Name(rawValue: ZCPresentationManagerDidPresented), object: animatorManager)
        NotificationCenter.default.addObserver(self, selector: #selector(titleChange), name: NSNotification.Name(rawValue: ZCPresentationManagerDidDismissed), object: animatorManager)

    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightClick))
        
        navigationItem.titleView = titleBtn
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func titleBtnClick(btn: TitleButton) {
//        btn.isSelected = !btn.isSelected
        
        let sb = UIStoryboard(name: "Popver", bundle: nil)
        
        guard let vc = sb.instantiateInitialViewController() else {
            return
        }
        
        vc.transitioningDelegate = animatorManager
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc private func titleChange() {
        titleBtn.isSelected = !titleBtn.isSelected
    }
    
    @objc func leftClick() {
        NJLog(message: "left")
    }
    
    @objc func rightClick() {
        NJLog(message: "right")
    }
    
    private lazy var animatorManager: ZCPresentationManager = {
       let manager = ZCPresentationManager()
        manager.presentFrame = CGRect(x: 100, y: 45, width: 200, height: 300)
        return manager
        
    }()
    
    
    private lazy var titleBtn: TitleButton = {
        let btn = TitleButton()
        btn.setTitle("小码哥", for: .normal)
        btn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
        return btn
    }()
}
