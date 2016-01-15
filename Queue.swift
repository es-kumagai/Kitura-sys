//
//  Queueing.swift
//  EnterpriseSwift
//
//  Created by Samuel Kallner on 10/21/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import Dispatch

public class Queue {
    private static var onMainOnceLock : Int = 0
    
    private let osQueue: dispatch_queue_t
    
    public init(type: QueueType, label: String?=nil) {
    
    #if os(Linux)
        let concurrent: COpaquePointer = get_dispatch_queue_concurrent()
    #else
        let concurrent = DISPATCH_QUEUE_CONCURRENT
    #endif

        osQueue = dispatch_queue_create(label != nil ? label! : "", concurrent)
    }
    
    public func queueAsync(block: () -> Void) {
        dispatch_async(osQueue, block)
    }
    
    public static func queueIfFirstOnMain(queue: Queue, block: () -> Void) {
        var onQueue = true
        
        SysUtils.doOnce(&onMainOnceLock) {
            dispatch_async(dispatch_get_main_queue(), block);
            onQueue = false
        }
        
        if  onQueue {
            queue.queueAsync(block)
        }
    }
}

public enum QueueType {
    case SERIAL, PARALLEL
}
