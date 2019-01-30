//
//  AppCell.swift
//  Services
//
//  Created by MXMACMINI1 on 07/08/18.
//  Copyright © 2018 MB. All rights reserved.
//

import UIKit

class AppCell: UITableViewCell {

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       self.appImage.layer.cornerRadius = appImage.frame.size.width/2
        self.layer.borderWidth = 5
        self.layer.borderColor = #colorLiteral(red: 0.7022942901, green: 0.8031344414, blue: 0.8204727769, alpha: 1)
        self.layer.cornerRadius = 20
        self.appImage.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
