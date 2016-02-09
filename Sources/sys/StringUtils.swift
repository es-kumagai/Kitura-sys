/**
* Copyright IBM Corporation 2015
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
**/

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
