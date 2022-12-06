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
    @IBOutlet var followBtn: UIButton!
    
    var followStatus: FollowStatus = .follow
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBAction func followBtnTapped(_ sender: UIButton) {
        
        followStatus.toggle()
        if followStatus == .unfollow{
            followBtn?.setTitle("Following",for: .normal)
            followBtn?.setTitleColor( .black, for: .normal )
            followBtn?.backgroundColor = .white
            followBtn?.layer.borderColor = CGColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
            followBtn?.layer.borderWidth = 1
            
            
        }
        else {
            followBtn?.setTitle("Follow",for: .normal)
            followBtn?.setTitleColor(.white, for: .normal)
            followBtn?.backgroundColor = UIColor(red: 77/255, green: 217/255, blue: 105/255, alpha: 1)
        }
    }
}
