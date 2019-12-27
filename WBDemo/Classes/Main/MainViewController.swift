//
//  MainViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/27.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.tintColor = .orange
//        addChildViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBar.addSubview(composeBtn)
        
        let rect = composeBtn.frame
        let width = tabBar.bounds.width / CGFloat(children.count)
        composeBtn.frame = CGRect(x: 2 * width, y: 0, width: width, height: rect.height)
    }
/*
    func add(childVCName: String?, title: String?, imageName: String?) {
        guard let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            NJLog(message: "获取命名空间失败")
            return
        }
        
        guard let cls: AnyClass = NSClassFromString(name + "." + (childVCName ?? "")), let typeCls = cls as? UIViewController.Type else {
            NJLog(message: "cls不能当做UIViewController")
            return
        }
        
        let childVC = typeCls.init()
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName ?? "")
        childVC.tabBarItem.selectedImage = UIImage(named: (imageName ?? "") + "_highlighted")
        
        let nav = UINavigationController(rootViewController: childVC)
        addChild(nav)
    }
    
    func addChildViewControllers() {
        
        guard let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            NJLog(message: "JSON文件不存在")
            return
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            return
        }
        
        do {
            let objc = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as! [[String : AnyObject]]
            
            for dic in objc {
                let title = dic["title"] as? String
                let name = dic["vcName"] as? String
                let imageName = dic["imageName"] as? String
                add(childVCName: name, title: title, imageName: imageName)
            }
        } catch {
            add(childVCName: "HomeViewController", title: "首页", imageName: "tabbar_home")
            add(childVCName: "MessageViewController", title: "消息", imageName: "tabbar_message_center")
            add(childVCName: "DiscoverViewController", title: "发现", imageName: "tabbar_discover")
            add(childVCName: "ProfileViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    */
    
    @objc private func composeClick(btn: UIButton) {
        NJLog(message: "btn")
    }
    
    private lazy var composeBtn: UIButton = { () -> UIButton in
        let btn = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        
        
        
        btn.addTarget(self, action: #selector(composeClick(btn:)), for: .touchUpInside)
        return btn
    }()

}
