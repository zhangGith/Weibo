//
//  ZCPresentationManager.swift
//  WBDemo
//
//  Created by Donview Dev on 2019/12/30.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class ZCPresentationManager: NSObject {
    private var isPresent = false
    
    var presentFrame = CGRect.zero
    
    
    private func willDismissController(transitionContext: UIViewControllerContextTransitioning) {
        guard let toview = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        transitionContext.containerView.addSubview(toview)
        toview.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
        toview.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            toview.transform = CGAffineTransform.identity
        }) { (_) -> Void in
            transitionContext.completeTransition(true)
        }
    }
    
    private func willDismissedController(transitionContext: UIViewControllerContextTransitioning) {
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

extension ZCPresentationManager: UIViewControllerTransitioningDelegate {
        // 该方法用于返回一个负责转场动画的对象
        // 可以在该对象中控制弹出视图的尺寸等
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = ZCPresentationController(presentedViewController: presented, presenting: presenting)
        pc.presentFrame = presentFrame
        return pc
        }
    // 该方法用于返回一个负责转场如何出现的对象
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        NotificationCenter.default.post(name: Notification.Name(ZCPresentationManagerDidPresented), object: self)
        return self
    }
    // 该方法用于返回一个负责转场如何消失的对象
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        NotificationCenter.default.post(name: Notification.Name(ZCPresentationManagerDidPresented), object: self)

        return self
    }
    
}

extension ZCPresentationManager: UIViewControllerAnimatedTransitioning {
    // 告诉系统展现和消失的动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    // 专门用于管理modal如何展现和消失的, 无论是展现还是消失都会调用该方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            willDismissController(transitionContext: transitionContext)
    
        } else {
            willDismissedController(transitionContext: transitionContext)
            
        }
    }
}
