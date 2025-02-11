//
//  ReelsCell.swift
//  Catstagram
//
//  Created by 김수비 on 2/6/25.
//

import UIKit
import SnapKit
import AVKit

class ReelsCell: UICollectionViewCell {
    static let identifier = "ReelsCell"
    
    var videoView: VideoPlayerView?
    
    // 릴스
    let cellTitleLabel = UILabel()
    
    // 카메라
    let cameraImageView = UIImageView()
    
    // 댓글
    let commentImageView = UIImageView()
    
    // 좋아요
    let likeImageView = UIImageView()
    
    // 공유하기
    let shareImageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    public func setupURL(_ urlStr: String){
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        setupAttribute()
        setupLayout()
    }
    
    private func setupAttribute() {
        // 릴스 라벨 작성
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.textColor = .white
        
        [cameraImageView, shareImageView, likeImageView, commentImageView].forEach {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white
        }
        
        cameraImageView.image = UIImage(systemName: "camera")
        shareImageView.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")
    }
    
    private func setupLayout() {
        guard let videoView = videoView else { return }
        contentView.addSubview(videoView)
        
        // 스냅킷 사용해 슈퍼뷰와 크기 동일하게 적용(ui를 코드로 작성할 수 있는 장점)
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [cellTitleLabel, cameraImageView,
         likeImageView,
         commentImageView,
         shareImageView]
            .forEach { contentView.addSubview($0) }
        
        // 릴스 라벨 오른쪽 상단에 위치
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 카메라 오토 레이아웃
        cameraImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
       
        let space = CGFloat(20)
        
        // 공유하기 버튼 레이아웃
        shareImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        // 댓글
        commentImageView.snp.makeConstraints { make in
            make.bottom.equalTo(shareImageView.snp.top).offset(-space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        
        // 좋아요
        likeImageView.snp.makeConstraints { make in
            make.bottom.equalTo(commentImageView.snp.top).offset(-space)
            make.centerX.equalTo(commentImageView)
            make.width.height.equalTo(35)
        }
    }
}

