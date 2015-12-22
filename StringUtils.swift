//
//  StringUtils.swift
//  Pods
//
//  Created by Samuel Kallner on 11/15/15.
//
//

import Foundation

public class StringUtils {
    
    public static func toUtf8String(str: String) -> NSData? {
        let data = str.dataUsingEncoding(NSUTF8StringEncoding)
        return data
    }
    
    public static func toNullTerminatedUtf8String(str: String) -> NSData? {
        let cString = str.cStringUsingEncoding(NSUTF8StringEncoding)
        let data = NSData(bytes: cString!, length: Int(strlen(cString!))+1)
        return data
    }
    
    public static func fromUtf8String(data: NSData) -> String? {
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        return str as? String
    }
}
