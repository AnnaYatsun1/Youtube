//
//  SettingsViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 27/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: -
    //MARK: Initializations
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Settings"
        self.view.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
