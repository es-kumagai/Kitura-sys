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

    #if os(Linux)
        let serial: COpaquePointer = nil
    #else
        let serial = DISPATCH_QUEUE_SERIAL
    #endif

        osQueue = dispatch_queue_create(label != nil ? label! : "", type == QueueType.PARALLEL ? concurrent : serial)
    }
    
    public func queueAsync(block: () -> Void) {
        dispatch_async(osQueue, block)
    }

    public func queueSync(block: () -> Void) {
        dispatch_sync(osQueue, block)
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
