//
//  UserTableViewCell.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.layer.borderWidth = 2
        title.layer.masksToBounds = false
        title.layer.borderColor = UIColor.white.cgColor
        title.layer.cornerRadius = (title.frame.width+title.frame.height)/4
        title.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:UserData) {
        title.text = "\(data.name.first ?? "K")"
        name.text = data.name
        email.text = data.email
    }
    
}
