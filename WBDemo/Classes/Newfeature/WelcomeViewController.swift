//
//  WelcomeViewController.swift
//  WBDemo
//
//  Created by Donview Dev on 2020/1/3.
//  Copyright © 2020 Block. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    @IBOutlet weak var iconBottomCons: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
        
        iconView.sd_setImage(with: NSURL(string: "http://clouddisk.donviewcloud.com//free/25/1569202779_25_7b4b8fe4a9b4c681c99f1a23ef8adebf.jpg") as URL?)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        iconBottomCons.constant = UIScreen.main.bounds.height - iconBottomCons.constant
        
        UIView.animate(withDuration: 2.0, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 2.0, animations: {
                self.titleLabel.alpha = 1.0
            }) { (_) in
                NJLog(message: "123")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
