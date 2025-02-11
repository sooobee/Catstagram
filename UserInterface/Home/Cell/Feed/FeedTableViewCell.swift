//
//  FeedTableViewCell.swift
//  Catstagram
//
//  Created by 김수비 on 1/22/25.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var buttonIsHeart: UIButton!
    @IBOutlet weak var buttonIsBookmark: UIButton!
    @IBOutlet weak var labelHowManyLike: UILabel!
    @IBOutlet weak var labelFeed: UILabel!
    @IBOutlet weak var imageViewMyProfile: UIImageView!
    
    // MARK: - Actions
    @IBAction func actionIsHeart(_ sender: Any) {
        if buttonIsHeart.isSelected {
            buttonIsHeart.isSelected = false
        } else {
            buttonIsHeart.isSelected = true
        }
    }
    
    @IBAction func actionBookmark(_ sender: Any) {
        if buttonIsBookmark.isSelected {
            buttonIsBookmark.isSelected = false
        } else {
            buttonIsBookmark.isSelected = true
        }
    }
    
    // MARK: - Helpers
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewUserProfile.layer.cornerRadius = 12.5
        imageViewUserProfile.clipsToBounds = true
        imageViewMyProfile.layer.cornerRadius = 12.5
        imageViewMyProfile.clipsToBounds = true
        
        // 아이디, 내용 폰트 굵기 다르게
        let fontSize = UIFont.boldSystemFont(ofSize: 9)
        let attributeStr = NSMutableAttributedString(string: labelFeed.text ?? "")
        // 0-6길이 만큼 fontSize설정
        attributeStr.addAttribute(.font, value: fontSize, range: NSRange.init(location: 0, length: 6))
        
        labelFeed.attributedText = attributeStr
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
