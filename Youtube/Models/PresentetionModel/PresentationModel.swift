//
//  PresentationModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 28/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit

protocol PresentationModel { // отвечает за верстку
    
    func prepareConstraints()
    func prepareLayout()
    func prepareStyle()
}

class BaseHomePresentationModel: PresentationModel {
    public let titles = ["YouTube", "Tranding", "Subscription", "Account"]
    public let menuBar = MenuBarView()
    public let redView = UIView()
    public var titleLable: UILabel?
    
    func prepareConstraints() {
        self.prepareConstraintsMenuBar()
        self.prepareConstraintsRedView()
    }
    
    func prepareLayout() {
        
    }
    
    func prepareStyle() {
        self.redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        self.titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: self.menuBar.frame.width, height: self.menuBar.frame.height))
        let navigationBarAppearace = UINavigationBar.appearance()
        self.titleLable?.tintColor = .white
        navigationBarAppearace.tintColor = .white
        self.titleLable?.text = self.titles.first
    }
    
    
    private func prepareConstraintsMenuBar() {
        
        self.menuBar.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)
            
            self.menuBar.superview.do {
                menuBar.topAnchor.constraint(equalTo: $0.safeAreaLayoutGuide.topAnchor).isActive = true
            }             
        }
    }
    
    private func prepareConstraintsRedView() {
        self.redView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)
        }
    }
    
}

class HomePresentationModel: BaseHomePresentationModel {
  
}

class TrendingPresentationModel: BaseHomePresentationModel {
    
}

class SubscriprionsPresentationModel: BaseHomePresentationModel {
    
}
