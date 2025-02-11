//
//  VideoPlayerView.swift
//  Catstagram
//
//  Created by 김수비 on 2/6/25.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer? // 레이아웃 관리
    var playerLooper: AVPlayerLooper? // 반복재생 관리
    var queuePlayer: AVQueuePlayer? // 재생 순서 관리
    var urlStr: String
    
    init(frame: CGRect, urlStr: String) {
        self.urlStr = urlStr
        super.init(frame: frame)
        // 여기
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer?.videoGravity = .resizeAspectFill // 사이즈 가득 채움
        
        self.layer.addSublayer(playerLayer!) // 현재 뷰에 레이어 넣음
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 영상 메모리 해제 필요
    public func cleanup() {
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
    }
    
    // 영상 업데이트 될 때 레이아웃 맞춰줌
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
}
