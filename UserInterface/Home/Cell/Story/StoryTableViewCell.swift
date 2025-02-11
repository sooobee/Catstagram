//
//  StoryTableViewCell.swift
//  Catstagram
//
//  Created by 김수비 on 1/29/25.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourseDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int){
        collectionView.delegate = dataSourseDelegate
        collectionView.dataSource = dataSourseDelegate
        collectionView.tag = row
        
        // 컬렉션 뷰를 넣음
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.reloadData()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
