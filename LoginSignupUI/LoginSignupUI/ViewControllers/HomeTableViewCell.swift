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
    @IBOutlet var postImgView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        followingBtn.layer.masksToBounds = true
        followingBtn.layer.cornerRadius = 15
        followingBtn.layer.borderWidth = 1
        followingBtn.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
    }
//    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        _ = segue.destination as! HomeViewController
//
//      //  homeViewController.data.postImg = postImg as? UIImage
//
//    }
    
}
