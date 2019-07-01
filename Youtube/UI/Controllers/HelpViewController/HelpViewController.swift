//
//  HelpViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 27/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

import UIKit

class HelpViewController: UIViewController {
    
    //MARK: -
    //MARK: Initializations
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Help"
        self.view.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
