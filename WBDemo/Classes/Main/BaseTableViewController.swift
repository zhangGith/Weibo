//
//  BaseTableViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/27.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var isLogin = true
    var visitorView: VisitorView?
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView() {
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.loginBtn.addTarget(self, action: #selector(loginBtnClick(btn:)), for: .touchUpInside)
        visitorView?.registerBtn.addTarget(self, action: #selector(registerBtnClick(btn:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(loginBtnClick(btn:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(registerBtnClick(btn:)))

    }
    
    
    
    @objc private func loginBtnClick(btn: UIButton) {
        NJLog(message: "")
    }
    
    @objc private func registerBtnClick(btn: UIButton) {
        NJLog(message: "")
    }
    

}
