//
//  StringUtils.swift
//  Pods
//
//  Created by Samuel Kallner on 11/15/15.
//
//
#if os(OSX) || os(iOS)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

import Foundation

public class StringUtils {
    
    public static func toUtf8String(str: String) -> NSData? {
        let nsstr:NSString = str.bridge()
        let data = nsstr.dataUsingEncoding(NSUTF8StringEncoding)
        return data
    }
    
    public static func toNullTerminatedUtf8String(str: String) -> NSData? {
        let nsstr:NSString = str.bridge()
        let cString = nsstr.cStringUsingEncoding(NSUTF8StringEncoding)
        let data = NSData(bytes: cString, length: Int(strlen(cString))+1)
        return data
    }
    
    public static func fromUtf8String(data: NSData) -> String? {
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        return str!.bridge()
    }
}

#if os(OSX) || os(iOS)
    
public extension String {
    func bridge() -> NSString {
        return self as NSString
    }
}

public extension NSString {
    func bridge() -> String {
        return self as String
    }
}

#endif
