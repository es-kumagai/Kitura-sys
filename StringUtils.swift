//
//  StringUtils.swift
//  Pods
//
//  Created by Samuel Kallner on 11/15/15.
//
//

import Foundation

public class StringUtils {
    static let kCFStringEncodingUTF8: UInt32 = 0x08000100
    
    public static func toUtf8String(str: String) -> [UInt8]? {
        let maxBufSize = CFStringGetMaximumSizeForEncoding(str.characters.count, kCFStringEncodingUTF8)
        let cStr = [UInt8](count: maxBufSize+1, repeatedValue: 0)
        let ok = CFStringGetCString(str, UnsafeMutablePointer<Int8>(cStr), maxBufSize, kCFStringEncodingUTF8)
        
        return ok ? cStr : nil
    }
    
    public static func toSignedUtf8String(str: String) -> [Int8]? {
        let maxBufSize = CFStringGetMaximumSizeForEncoding(str.characters.count, kCFStringEncodingUTF8)
        let cStr = [Int8](count: maxBufSize+1, repeatedValue: 0)
        let ok = CFStringGetCString(str, UnsafeMutablePointer<Int8>(cStr), maxBufSize, kCFStringEncodingUTF8)
        
        return ok ? cStr : nil
    }
    
    public static func fromUtf8String(utf8Str: UnsafePointer<UInt8>) -> String? {
        let length = Int(strlen(UnsafePointer<Int8>(utf8Str)))
        return fromUtf8String(utf8Str, withLength: length)
    }
    
    public static func fromUtf8String(int8Str: UnsafePointer<Int8>) -> String? {
        let length = Int(strlen(int8Str))
        return fromUtf8String(int8Str, withLength: length)
    }
    
    public static func fromUtf8String(int8Str: UnsafePointer<Int8>, withLength length: Int) -> String? {
        return fromUtf8String(UnsafePointer<UInt8>(int8Str), withLength: length)
    }
    
    public static func fromUtf8String(utf8Str: UnsafePointer<UInt8>, withLength length: Int) -> String? {
        return CFStringCreateWithBytes(kCFAllocatorDefault, utf8Str, length, CFStringBuiltInEncodings.UTF8.rawValue, false) as String
    }
}
