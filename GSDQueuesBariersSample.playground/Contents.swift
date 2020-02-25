import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 20) { (index) in
    array.append(index)
}
print("UnsafeAray: \(array)")

class SafeArray<Element> {
    private var array = [Element]()
    private var queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }
    public var elements: [Element]{
        var result = [Element]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 20) { (index) in
    safeArray.append(element: index)
}
print("SafeArray: \(safeArray.elements)")
