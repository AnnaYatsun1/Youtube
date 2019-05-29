//
//  Model.swift
//  Youtube
//
//  Created by Anna Yatsun on 21/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


class Model<Value>: ObservableObject<Event> {
    
    // MARK:
    // MARK:  Accessors
    
    var value: Value {
        get { return self.mutableValue }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    
    //MARK: -
    //MARK: Initializations
    
    init(_ value: Value) {      
        self.mutableValue = value
    }
    
    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        defer { self.notify(new: .update) }
        
        return action(&self.mutableValue)
    }
}
