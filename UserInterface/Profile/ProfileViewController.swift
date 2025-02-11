//
//  ProfileViewController.swift
//  Catstagram
//
//  Created by 김수비 on 2/1/25.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
//    var userFeedData: UserFeedModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    private func setupCollectionView(){
        // delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // cell  등록
        profileCollectionView.register(UINib(
            nibName: "ProfileCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifer)
        
        profileCollectionView.register(UINib(
            nibName: "PostCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 섹션의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // cell의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 24
        }
    }
    
    // cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifer, for: indexPath) as? ProfileCollectionViewCell else {
                    fatalError("셀 타입캐스팅 실패...")
            }
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                    fatalError("셀 타입캐스팅 실패...")
            }

//            cell.setupData() // <-- 이미지 데이터 전달
            return cell
        }
    }
}

// 셀 크기
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        switch section {
        case 0: return CGSize(width: collectionView.frame.width,
                              height: CGFloat(159))
        default:
            // 셀 한변의 길이
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(width: side,
                          height: side)
        }
    }
    
    // postCell 아이템 간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
    // postCell 라인 간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}
