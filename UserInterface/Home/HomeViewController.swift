//
//  HomeViewController.swift
//  Catstagram
//
//  Created by 김수비 on 1/22/25.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var arrayCat : [FeedModel] = []
    let imagePickerViewController = UIImagePickerController()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // homeviewController가 tableView의 역할을 위임받음(delegate)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        
        // tableView에 만든 셀을 등록
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        // API 호출
        let input = FeedAPIInput(limit: 100, page: 0)
        FeedDataManager().FeedDataManager(input, self)
        
        // imagePicker의 역할 위임
        imagePickerViewController.delegate = self

        
    }
    
    // MARK: - Actions
    @IBAction func buttonGoAlbum(_ sender: Any) {
        
        // 피드 추가하기
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController,animated: true, completion: nil)
        
    }
}


// MARK: - Extension
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    // 셀 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    }
    
    //셀 뭘쓸건지?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 첫번째 셀일 때 스토리뷰 셀을 띄움
        // 등록한 셀을 (재)사용
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {
                return UITableViewCell()
            }
            return cell
        // 피드 셀
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
                return UITableViewCell()
            }
            
            if let urlString = arrayCat[indexPath.row - 1].url {
                let url = URL(string: urlString)
                
                // kingfisher로 url -> 이미지 캐싱
                cell.imageViewFeed.kf.setImage(with: url)
                
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 600
        }
    }
    
    // 스토리 셀 항상 떠있도록
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourseDelegate: self, forRow: indexPath.row)
    }
}

// 스토리 셀
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}

// API 호출 성공 시 실행
extension HomeViewController {
    func successAPI(_ result: [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

// 앨범 사진 누르면 피드 업로드
extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageString = "이미지저장소"
            let input = FeedUploadInput(content: "내고양이입니다.", postImgsUrl: [imageString])
            FeedUploadDataManger().posts(input, self)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
