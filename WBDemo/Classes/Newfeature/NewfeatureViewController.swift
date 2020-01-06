//
//  NewfeatureViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2020/1/3.
//  Copyright © 2020 Block. All rights reserved.
//

import UIKit
import SnapKit

class NewfeatureViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var maxCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension NewfeatureViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newfeaCell", for: indexPath) as! ZCNewfeatureCell
        cell.backgroundColor = (indexPath.item % 2 == 0) ? UIColor.red : UIColor.purple
        cell.index = indexPath.item
        return cell
    }
}

extension NewfeatureViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = collectionView.indexPathsForVisibleItems.last!
        let currentCell = collectionView.cellForItem(at: index) as! ZCNewfeatureCell
        if index.item == maxCount - 1 {
            currentCell.startAnimation()
        }
    }
}

class ZCNewfeatureCell: UICollectionViewCell {
    var index: Int = 0 {
        didSet {
            
            iconView.image = UIImage(named: "new_feature_\(index + 1)")
            startBtn.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        
        iconView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        startBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-100)
        }
    }
    
    func startAnimation() {
        startBtn.isHidden = false
        startBtn.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        startBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
            self.startBtn.transform = .identity
        }) { (_) in
            self.startBtn.isUserInteractionEnabled = true
        }
    }
    
    @objc private func startClick(btn: UIButton) {
        
    }
    
    //MARK: - lazy
    private lazy var iconView = UIImageView()
    private lazy var startBtn: UIButton = {
       let btn = UIButton(imageName: "", backgroundImageName: "new_feature_button")
        btn.addTarget(self, action: #selector(startClick(btn:)), for: .touchUpInside)
        return btn
    }()
}


class ZCNewfeatureLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
    }
}
