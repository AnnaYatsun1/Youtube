//
//  Result.swift
//  Weather
//
//

import Foundation

//public enum Result<Value> {
//    case success(Value)
//    case failure(Error)  
//
//    // MARK: - Public API
//    public var value: Value? {
//        switch self {
//        case .success(let value): return value
//        case .failure: return nil
//        }
//    }
//
//    public var error: Error? {
//        switch self {
//        case .success: return nil
//        case .failure(let error): return error
//        }
//    }
//}
//

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
    
    init(success: Value?, error: Error?, `default`: Error) {
        
        self = error
            .map(Result.init)
            ?? success.map(Result.init) 
            ?? Result(error: `default` )
    }
    
    public init(value: Value) {
        self = .success(value)
    }
    
    public init(error: Error) {
        self = .error(error)
    }
    
    public static func lift<Value, Error: Swift.Error>(_ value: Value) -> Result<Value, Error> {
        return .success(value)
    }
    
    public static func lift<Value, Error: Swift.Error>(_ error: Error) -> Result<Value, Error> {
        return .error(error)
    }
    
    public var result: Result<Value, Error> {
        return self.analysis(success: {Result(value: $0)}, failure: {Result(error: $0)} )
    }
    
    public var value: Value? {
        return self.analysis(success: identity, failure: alwaysNil)
    }
    
    public var error: Error? {
        return self.analysis(success: alwaysNil, failure: identity)
    }
    
    public func analysis<Return>(success: (Value) -> Return, failure: (Error) -> Return) -> Return {
        switch self {
        case .success(let value): return success(value)
        case .error(let error): return failure(error)
        }
    }
    
    public func bimap<NewValue, NewError>(
        success: (Value) -> NewValue,
        failure: (Error) -> NewError
        )
        -> Result<NewValue, NewError>
    {
        return self.analysis(
            success: { Result.lift(success($0)) },
            failure: { Result.lift(failure($0)) }
        )
    }
    
    public func map<NewValue>(_ transform:(Value) -> NewValue) -> Result<NewValue, Error>
    {
        return self.bimap(success: transform, failure: identity)
    }
    
    public func flatMap<NewValue>(_ transform: (Value) -> Result<NewValue, Error>) -> Result<NewValue, Error>
    {
        return self.analysis(success: transform, failure: Result.lift)
    }
    
    public func flatMapError<NewError>(_ transform: (Error) -> Result<Value, NewError>) -> Result<Value, NewError>
    {
        return self.analysis(success: Result.lift, failure: transform)
    }
}
