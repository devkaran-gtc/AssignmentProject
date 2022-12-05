//
//  FollowerTableViewCell.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

   
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var nickNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
