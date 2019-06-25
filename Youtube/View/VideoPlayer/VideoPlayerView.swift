//
//  VideoPlayerView.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import AVFoundation

fileprivate struct Constants {
    static let utl = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
}

class VideoPlayerView: UIView, Spinnable {
    // MARK:
    // MARK:  Accessors 
    private let player: AVPlayer?
    private let conteinerView: UIView?
    private let interval = CMTime(value: 1, timescale: 2)
    
    private var isPlaing = false
   
    private let playStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlerPause), for: .touchUpInside)
        
        return button
    }()
    
    private let videoLengthLabel: UILabel = {
        let lable = UILabel()
        lable.text = "00:00"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textAlignment = .right
        
        return lable
    }()
    
    private let curentTimeLable: UILabel = {
        let lable = UILabel()
        lable.text = "00:00"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        
        return lable
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "circle"), for: .normal)
        slider.addTarget(self, action: #selector(hendlerSelector), for: .valueChanged)
        
        return slider
    }()
    
    //MARK: -
    //MARK: Initializations
    
    override init(frame: CGRect) {
        self.player = AVPlayer(url: URL(string: Constants.utl)!)
        let playerLayer  = AVPlayerLayer(player: player)
        self.conteinerView = UIView(frame: frame)
        conteinerView?.backgroundColor = UIColor(white: 0, alpha: 1)
        super.init(frame: frame)
        
        self.backgroundColor = .black
        self.layer.addSublayer(playerLayer)
        
        self.conteinerView.do {
            self.addSubview($0)
        }
        self.addSubview(self.playStopButton)
        
        playerLayer.frame = self.frame
        self.player?.play()
        self.showSpinner()
        self.player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        self.addTimerObserver()
        self.addSubview(self.videoLengthLabel)
        self.addSubview(self.curentTimeLable)
        self.addSubview(self.slider)
        self.createSliderConstraints()
        self.createCurentTimeConstraints()
        self.createVideoLengthConstraints()
        self.createPlayStopButtonConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            self.hideSpinner()
            self.conteinerView?.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.playStopButton.isHidden = false
            self.player?.currentItem.do { item in
                self.calculateTime(lable: self.videoLengthLabel, timer: item.duration)
            }
        }
    }
    
    @objc func handlerPause(_ sender: UIButton) {
        call(!self.isPlaing ? self.play : self.stop)
        self.isPlaing.toggle()
    }
    
    @objc func hendlerSelector() {
        self.player?.currentItem.do { item in
            let totalSeconds = CMTimeGetSeconds(item.duration)
            let value = Float64(self.slider.value) * totalSeconds
            let seekTimer = CMTime(value: Int64(value), timescale: 1)
            self.player?.seek(to: seekTimer) { _ in 
            }
        }
    }
    
    // MARK:
    // MARK:  Private
    private func play() {
        self.player?.pause()
        self.playStopButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func stop() {
        self.player?.play()
        self.playStopButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    private func createSliderConstraints() {
        self.slider.snp.makeConstraints { maker in
            maker.left.equalTo(self.curentTimeLable.snp.right)
            maker.right.equalTo(self.videoLengthLabel.snp.left)
            maker.bottom.equalToSuperview()
            maker.height.equalTo(30)
        }
    }
    
    private func createCurentTimeConstraints() {
        self.curentTimeLable.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview()
            maker.width.equalTo(50)
            maker.height.equalTo(24)
        }
    }
    
    private func createVideoLengthConstraints() {
        self.videoLengthLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview()
            maker.width.equalTo(50)
            maker.height.equalTo(24)
        }
    }

    private func createPlayStopButtonConstraints() {
        self.playStopButton.snp.makeConstraints { maker in 
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalTo(50)
            maker.height.equalTo(50)
        } 
    }
    
    private func addTimerObserver() {
        self.player?.addPeriodicTimeObserver(forInterval: self.interval, queue: DispatchQueue.main) { timer in
            self.calculateTime(lable: self.curentTimeLable, timer: timer)
        }
    }
    
    private func calculateTime(lable: UILabel, timer: CMTime) {
        let totalSeconds = CMTimeGetSeconds(timer)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        let minutes = Int((totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        lable.text = "\(minutes): \(seconds)"
    }
}

