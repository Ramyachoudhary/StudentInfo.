//
//  StudentDetail.swift
//  Services
//
//  Created by MXMACMINI1 on 03/01/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit
import Kingfisher
class StudentDetail: UIViewController {

    @IBOutlet weak var cell: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var image: UIImageView!
    var detailsArray = [(images:String,first:String,last:String,street:String,city:String,email:String,phone:String,cell:String)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.isHidden = true
         image.kf.setImage(with: URL(string: (detailsArray[0].images)))
         image.layer.masksToBounds = true
         firstName.text = detailsArray[0].first
         lastName.text = detailsArray[0].last
         street.text = detailsArray[0].street
        city.text = detailsArray[0].city
        email.text = detailsArray[0].email
        phone.text = detailsArray[0].phone
        cell.text = detailsArray[0].cell
          Timer.scheduledTimer(timeInterval:0.7, target: self, selector: #selector(self.LoginLogoActive), userInfo:nil, repeats:false)
        // Do any additional setup after loading the view.
    }
    @objc func LoginLogoActive() {
        stack.isHidden = false
        stack.alpha = 0.0
        UIView.animate(withDuration:0.5, delay:0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.stack.alpha = 1.0
        }, completion: nil)
    }

    @IBAction func onBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
