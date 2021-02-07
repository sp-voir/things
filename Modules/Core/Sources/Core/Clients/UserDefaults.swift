//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation

public struct UserDefaultsClient {
    public var save: (String, Value) -> Void
    public var load: (String) -> Value?
    public var delete: (String) -> Void
    
    public enum Value {
        case any(Any)
        case float(Float)
        case double(Double)
        case int(Int)
        case bool(Bool)
        
        public var any: Any? {
            get {
                guard case let .any(value) = self else { return nil }
                return value
            }
            set {
                guard case let .any(value) = self else { return }
                self = .any(value)
            }
        }
        
        public var float: Float? {
            get {
                guard case let .float(value) = self else { return nil }
                return value
            }
            set {
                guard case let .float(value) = self else { return }
                self = .float(value)
            }
        }
        
        public var double: Double? {
            get {
                guard case let .double(value) = self else { return nil }
                return value
            }
            set {
                guard case let .double(value) = self else { return }
                self = .double(value)
            }
        }
        
        public var int: Int? {
            get {
                guard case let .int(value) = self else { return nil }
                return value
            }
            set {
                guard case let .int(value) = self else { return }
                self = .int(value)
            }
        }
        
        public var bool: Bool? {
            get {
                guard case let .bool(value) = self else { return nil }
                return value
            }
            set {
                guard case let .bool(value) = self else { return }
                self = .bool(value)
            }
        }
    }
}

extension UserDefaultsClient {
    public static let live: UserDefaultsClient = {
        let userDefaults = UserDefaults.standard
        return UserDefaultsClient(
            save: { key, value in
                switch value {
                case .any(let value):
                    userDefaults.set(value, forKey: key)
                case .float(let value):
                    userDefaults.set(value, forKey: key)
                case .double(let value):
                    userDefaults.set(value, forKey: key)
                case .int(let value):
                    userDefaults.set(value, forKey: key)
                case .bool(let value):
                    userDefaults.set(value, forKey: key)
                }
            },
            load: { key in
                guard let value = userDefaults.object(forKey: key) else { return .none }
                if let value = value as? Bool   { return .bool(value)   }
                if let value = value as? Int    { return .int(value)    }
                if let value = value as? Double { return .double(value) }
                if let value = value as? Float  { return .float(value)  }
                return .any(value)
            },
            delete: { key in userDefaults.removeObject(forKey: key) })
    }()
}

