//
//  FavouriteTableViewCell.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/19/22.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet var profileImage1: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
