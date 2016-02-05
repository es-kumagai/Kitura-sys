//
//  SysUtils.swift
//  sys
//
//  Created by Samuel Kallner on 10/28/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import Dispatch

public class SysUtils {

    public static func doOnce(lock: UnsafeMutablePointer<Int>, block: () -> Void) {
        dispatch_once(lock, block)
    }

}
