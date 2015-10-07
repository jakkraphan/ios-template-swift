//
//  FSExtensions+Dictionary.swift
//  SwiftHelpers
//

import Foundation

extension Dictionary {
    
    func objectForKey(key:String, orDefault def:AnyObject) -> Value {
        let res = key as! Key
        
        if self[res] != nil {
            return self[res]!
        } else {
            return def as! Value
        }
    }
}
