//
//  HomePresentationModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class HomePresentationModel: PresentationModel {
    var containerView: UIView
    
    
    public let titles = ["YouTube", "Tranding", "Subscription", "Account"]
    public var titleLable: UILabel?
    
    init() {
        self.containerView = UIView()
    }
    
    func prepareConstraints() {
        self.prepareConstraintsMenuBar()
        self.prepareConstraintsRedView()
    }
    
    func prepareLayout() {
        
    }
    
    func prepareStyle() {
        let navigationBarAppearace = UINavigationBar.appearance()
        self.titleLable?.tintColor = .white
        navigationBarAppearace.tintColor = .white
        self.titleLable?.text = self.titles.first
    }
    
    
    private func prepareConstraintsMenuBar() {
        
    }
    
    private func prepareConstraintsRedView() {
        
    }
}
