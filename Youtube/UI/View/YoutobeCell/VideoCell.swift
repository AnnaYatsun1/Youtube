//
//  VideoCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 04/04/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher 

class VideoCell: BaseCell {

    // MARK:
    // MARK:  Accessors
    public var video: Video?  {
        didSet {
            self.video?.title.do {
                self.titleLable.text = $0
                let size = CGSize(
                    width: self.frame.width - 16 - 44 - 8 - 16, 
                    height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(
                    string: $0)
                        .boundingRect(
                            with: size, 
                            options: options, 
                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], 
                            context: nil
                        )
                if estimatedRect.size.height > 20 {
                    self.titleLableHightConstrain?.update(inset: 44) 
                } else {
                     self.titleLableHightConstrain?.update(inset: 20) 
                }
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        return imageView 
    }()
    
    let titleLable: UILabel = {
        let imageView = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.numberOfLines = 2
        
        return imageView 
    }()
    
    let subTitleTixtView: UITextView = {
        let imageView = UITextView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        imageView.textColor = UIColor.lightGray
        
        return imageView 
    }()
    
    let separatorView: UIView = {
        let view  = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)

        return view
    }()
    
    private var titleLableHightConstrain: Constraint?
    
    // MARK:
    // MARK:  View Life Cycle
    
    override func setupViews() {
        self.addSubview(self.thumbnailImageView) 
        self.addSubview(self.separatorView)
        self.addSubview(self.userProfileImageView)
        self.addSubview(self.titleLable)
        self.addSubview(self.subTitleTixtView)
        
        self.thumbnailImageView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(16)
            maker.top.equalToSuperview().inset(16)
            maker.bottom.top.equalTo(self.snp.bottom).inset(55)
        }
        
        self.separatorView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(1)
            maker.bottom.equalTo(self.subTitleTixtView.snp.bottom).offset(4)
        }
      
        self.userProfileImageView.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(44)
            maker.left.equalToSuperview().inset(16)
            maker.bottom.equalTo(self.thumbnailImageView.snp.bottom).offset(50)
        }
        
        self.titleLable.snp.makeConstraints { (maker) in
            maker.left.equalTo(userProfileImageView.snp.right).multipliedBy(1).offset(10)
            maker.right.equalTo(thumbnailImageView.snp.right).multipliedBy(1).offset(8)
            maker.top.equalTo(thumbnailImageView.snp.bottom).multipliedBy(1).offset(8)
        }
        
        self.subTitleTixtView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLable.snp.bottom).multipliedBy(1)
            maker.left.equalTo(userProfileImageView.snp.right).multipliedBy(1).offset(10)
            maker.right.equalTo(thumbnailImageView.snp.right).multipliedBy(1)
            maker.height.equalToSuperview().multipliedBy(0).offset(30)
        }        
    }
    
    func fill(video: Video) {
        self.titleLable.text = video.title
        
        let urlString = video.tubnnailImageName 
        let url = URL(string: urlString)
        let placeholder = Image(named: "placeholder")
        self.thumbnailImageView.kf.setImage(with: url, placeholder: placeholder)
        
        let userProfileImage = video.channel.profileImageName
        let urlImageProfile = URL(string: userProfileImage)
        self.userProfileImageView.kf.setImage(with: urlImageProfile)
        
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        
        video.numberOfViews.do {
            let string = formater.string(from: NSNumber(integerLiteral: $0))
            let nill = " "
            self.subTitleTixtView.text = video.channel.name + nill + string!
        }
    }
    
    override func prepareForReuse() {
        self.thumbnailImageView.kf.cancelDownloadTask()
        self.userProfileImageView.kf.cancelDownloadTask()
    }
}


extension UIView {
    func addConstrainsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}
