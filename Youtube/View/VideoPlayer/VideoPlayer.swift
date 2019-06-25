//
//  VideoPlayer.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
// can replace for Controller
class VideoPlayer: UIViewController {
    
    // MARK:
    // MARK:  Accessors
    
   private var videoPayerView: VideoPlayerView?
    
    // MARK:
    // MARK:  Public 
    
    public func setupVideoPlayer() {
        UIApplication.shared.keyWindow.do { keyWindow in
            self.view.frame = keyWindow.frame
            self.view.frame = CGRect(x: keyWindow.frame.width - 100, y: keyWindow.frame.height - 100, width: 100, height: 100)
            self.view.backgroundColor = .white
            
            self.view.addSubview(self.setupVideoView())
            keyWindow.addSubview(self.view)
            
            UIView.animate(withDuration: 0.5) {
                self.view.frame =  keyWindow.frame
            } 
        }
    }
    
    // MARK:
    // MARK:  Private 
    
    private func setupVideoView() -> VideoPlayerView {
        UIApplication.shared.keyWindow.do { keyWindow in
            let videoPlayerViewHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerViewFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerViewHeight)
            self.videoPayerView = VideoPlayerView(frame: videoPlayerViewFrame)
            
        }
        return self.videoPayerView!
    }
}
