//
//  TitleButton.swift
//  WBDemo
//
//  Created by Block on 2019/12/29.
//  Copyright © 2019 Block. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        
        setTitleColor(UIColor.darkGray, for: .normal)
        sizeToFit()
        
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle((title ?? "") + "  ", for: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame.origin.x = titleLabel!.frame.width
        titleLabel?.frame.origin.x = 0
    }
}
