//
//  ArrayModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 20/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ArrayModel<T: AnyObject>: ObservableObject<Event> { 
    
    // MARK:
    // MARK:  Accessors
    
    public private(set) var values = [T]()
    private var observer = CancellableObject()
    
    public var count: Int {
        return self.values.count
    }
    
    public var isEmpty: Bool {
        return self.values.isEmpty
    }
    
    //MARK: -
    //MARK: Initializations
    
    init(values: [T]) {
        super.init()
        
        self.values = values
    }
        
    //MARK: -
    //MARK: Public
    
    public func add(value: T) {
        self.values.append(value)
        self.notify(new: .add)
    }
    public func addAll(values: [T]) {
        self.values.append(contentsOf: values)
        self.notify(new: .add)
    }
    
    public func remove(at index: Int) {
        self.values.remove(at: index)
        self.notify(new: .remove)
    }
    
    public func removeAll() {
        self.values.removeAll()
        self.notify(new: .remove)
    }
    
    subscript(index: Int) -> Model<T> {
        let model = Model(self.values[index])
        model.observer(handler: self.notify)
        
        return model
    }
}
