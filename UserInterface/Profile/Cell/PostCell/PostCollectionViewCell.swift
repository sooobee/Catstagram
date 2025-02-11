//
//  PostCollectionViewCell.swift
//  Catstagram
//
//  Created by 김수비 on 2/2/25.
//

import UIKit
import Kingfisher

class PostCollectionViewCell:
    UICollectionViewCell {
    
    @IBOutlet weak var PostImageview: UIImageView!
    
    static let identifier = "PostCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupData(_ imageURLStr: String?){
        // 이미지뷰의 이미지를 업로드 한다.
        
        guard let imageURLStr = imageURLStr else { return }
        
        if let url = URL(string: imageURLStr){
            PostImageview.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"))
        }
        
    }

}
