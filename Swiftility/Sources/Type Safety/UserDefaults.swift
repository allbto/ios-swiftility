//
//  UserDefaults.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/1/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

/// Extends UserDefaults to use a system similar to NSNotification.Name
extension UserDefaults
{
    public struct Key: RawRepresentable, Equatable, Hashable, Comparable
    {
        public var rawValue: String
        
        public init(rawValue: String)
        {
            self.rawValue = rawValue
        }
        
        public var hashValue: Int {
            return self.rawValue.hashValue
        }
    }
    
    open func object(for defaultName: Key) -> Any? { return self.object(forKey: defaultName.rawValue) }
    open func string(for defaultName: Key) -> String? { return self.string(forKey: defaultName.rawValue) }
    open func array(for defaultName: Key) -> [Any]? { return self.array(forKey: defaultName.rawValue) }
    open func data(for defaultName: Key) -> Data? { return self.data(forKey: defaultName.rawValue) }
    open func stringArray(for defaultName: Key) -> [String]? { return self.stringArray(forKey: defaultName.rawValue) }
    open func integer(for defaultName: Key) -> Int { return self.integer(forKey: defaultName.rawValue) }
    open func float(for defaultName: Key) -> Float { return self.float(forKey: defaultName.rawValue) }
    open func double(for defaultName: Key) -> Double { return self.double(forKey: defaultName.rawValue) }
    open func bool(for defaultName: Key) -> Bool { return self.bool(forKey: defaultName.rawValue) }
    open func url(for defaultName: Key) -> URL? { return self.url(forKey: defaultName.rawValue) }
    open func dictionary(for defaultName: Key) -> [String : Any]? { return self.dictionary(forKey: defaultName.rawValue) }
    
    open func removeObject(for defaultName: Key) { self.removeObject(forKey: defaultName.rawValue) }
    open func set(_ value: Any?, for defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Int, for defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Float, for defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Double, for defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Bool, for defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ url: URL?, for defaultName: Key) { self.set(url, forKey: defaultName.rawValue) }
    
    open func register(defaults registrationDictionary: [Key : Any])
    {
        let defaults: [String: Any] = registrationDictionary.reduce([:]) { (res, entry) in
            var res = res
            res.updateValue(entry.value, forKey: entry.key.rawValue)
            return res
        }
        
        self.register(defaults: defaults)
    }
}
