//
//  ReelsViewController.swift
//  Catstagram
//
//  Created by 김수비 on 2/6/25.
//

import UIKit

class ReelsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collecitonView: UICollectionView!
    private let videioURLStrArr = ["dummyVideo", "dummyVideo2"]
    private var nowPage = 0
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helpers
    private func setupCollectionView() {
        collecitonView.delegate = self
        collecitonView.dataSource = self
        collecitonView.decelerationRate = .fast
        
        collecitonView.register(ReelsCell.self, forCellWithReuseIdentifier: ReelsCell.identifier)
        
        startLoop()
    }
    
    private func startLoop() {
        // 반복됨, 2초마다 moveNextPage 실행
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collecitonView.numberOfItems(inSection: 0)
        
        nowPage += 1
        
        if(nowPage >= itemCount) {
            // 처음 페이지로 넘어감(12개 이상일 때)
            nowPage = 0
        }
        
        collecitonView.scrollToItem(
            at: IndexPath(item: nowPage, section: 0),
            at: .centeredVertically,
            animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 컬렉션뷰와 셀을 연결
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCell.identifier, for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videioURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 셀 보여주는게 끝났을 때 cleanup 실행 -> 메모리 정리
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            cell.videoView?.cleanup()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    // 릴스 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
    // 셀간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
