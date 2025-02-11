//
//  ProfileCollectionViewCell.swift
//  Catstagram
//
//  Created by 김수비 on 2/1/25.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var addProfileImageview: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
        
    @IBOutlet weak var addFriendButton: UIButton!
    
    @IBOutlet weak var postingCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var follwingCountLabel: UILabel!
    
    static let identifer = "ProfileCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAttribute()
    }
    
    private func setupAttribute() {
        profileImageView.layer.cornerRadius = 88 / 2
        addProfileImageview.layer.cornerRadius = 24 / 2
        
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 1

        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.darkGray.cgColor
        editButton.layer.borderWidth = 1
        
        addFriendButton.layer.cornerRadius = 5
        addFriendButton.layer.borderColor = UIColor.lightGray.cgColor
        addFriendButton.layer.borderWidth = 1
        
        
        // 게시물, 팔로워, 팔로잉 랜덤 값
        [postingCountLabel, followerCountLabel, follwingCountLabel].forEach {
            $0?.text = "\(Int.random(in: 0...10))"}
    }

}
