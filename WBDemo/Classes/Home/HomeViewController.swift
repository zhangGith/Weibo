//
//  HomeViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/27.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupVisitorInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        

        setupNav()
    }
    
    private func setupNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(leftClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(rightClick))
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("小码哥", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    @objc private func titleBtnClick(btn: TitleButton) {
        btn.isSelected = !btn.isSelected
        
        let sb = UIStoryboard(name: "Popver", bundle: nil)
        
        guard let vc = sb.instantiateInitialViewController() else {
            return
        }
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    

    
    @objc func leftClick() {
        NJLog(message: "left")
    }
    
    @objc func rightClick() {
        NJLog(message: "right")
    }
    
    private var isPresent = false


}

extension HomeViewController: UIViewControllerTransitioningDelegate {
        
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZCPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
}

extension HomeViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            guard let toview = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
            }
            transitionContext.containerView.addSubview(toview)
            toview.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
            
            let duration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration, animations: { () -> Void in
                toview.transform = CGAffineTransform.identity
            }) { (_) -> Void in
                transitionContext.completeTransition(true)
            }
    
        } else {
            guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                return
            }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                fromView.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.00001)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
        }
    }
}
