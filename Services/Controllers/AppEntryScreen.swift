//
//  AppEntryScreen.swift
//  Services
//
//  Created by MXMACMINI1 on 03/01/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class AppEntryScreen: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var appImage: UIImageView!
    override func viewDidLoad() {
        stack.isHidden = true
        super.viewDidLoad()
                UIView.animate(withDuration: 2.0) {
                    self.appImage.transform = CGAffineTransform(translationX:0, y:-200)
           }
         Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(self.LoginLogoActive), userInfo:nil, repeats:false)
        // Do any additional setup after loading the view.
    }
    @objc func LoginLogoActive() {
        stack.isHidden = false
        stack.alpha = 0.0
        UIView.animate(withDuration:1.5, delay:0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.stack.alpha = 1.0
        }, completion: nil)
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
