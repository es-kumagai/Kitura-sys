//
//  Error.swift
//  io
//
//  Created by Samuel Kallner on 11/16/15.
//  Copyright © 2015 IBM. All rights reserved.
//

public class Error : ErrorType, CustomStringConvertible {
    
    public let localizedDescriptionKey = "key.localizedDescription"
    public let localizedFailureReasonKey = "key.localizedFailureReason"
    
    public let domain: String
    public let code: Int
    public let userInfo: [String:AnyObject]
    
    public var localizedDescription: String {
        if  let result = userInfo[localizedDescriptionKey] {
            return result as! String
        }
        else {
            return "\(domain) code=\(code)"
        }
    }
    
    public var localizedFailureReason: String? {
        return userInfo[localizedFailureReasonKey] as! String?
    }
    
    public var description: String { return localizedDescription }
    
    public init(domain: String, code: Int, userInfo: [String: AnyObject]) {
        self.domain = domain
        self.code = code
        self.userInfo = userInfo
    }
}
