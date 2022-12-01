//
//  HomeTableViewCell.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var placeLbl: UILabel!
    @IBOutlet var followingBtn: UIButton!
    @IBOutlet var postImg: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
