//
//  RootViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

class RootViewController<PresentationViewModel: PresentationModel, Events, ViewModelType: ViewModel<Events>, Model: ControllerModel>: UIViewController {
    
    // отвечает за навигацию, и вызова моделей
    
    let presentationModel: PresentationViewModel
    let viewModel: ViewModelType
    let model: Model
    
    
    init(presentationModel: PresentationViewModel, viewModel: ViewModelType, model: Model) {
        self.presentationModel = presentationModel
        self.viewModel = viewModel
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.configure()
        self.presentationModel.prepareLayout()
        self.presentationModel.prepareStyle()
        self.presentationModel.prepareConstraints()
    }
}
