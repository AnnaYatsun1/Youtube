//
//  VideoPlayer.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class VideoPlayer {
    
    // MARK:
    // MARK:  Public 
    
    public func setupVideoPlayer() {
        print("SetupVideoPlayer")
        UIApplication.shared.keyWindow.do { keyWindow in
            let videoView = UIView(frame: keyWindow.frame)
            videoView.frame = CGRect(x: keyWindow.frame.width - 100, y: keyWindow.frame.height - 100, width: 100, height: 100)
            videoView.backgroundColor = .white
            
            let videoPlayerViewHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerViewFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerViewHeight)
            let videoPayerView = VideoPlayerView(frame: videoPlayerViewFrame)
            
            videoView.addSubview(videoPayerView)
            keyWindow.addSubview(videoView)
            
            UIView.animate(withDuration: 0.5) {
                videoView.frame =  keyWindow.frame
            } 
        }
    }
    
    public func setupVidePlayerView() {
        
    }
}
