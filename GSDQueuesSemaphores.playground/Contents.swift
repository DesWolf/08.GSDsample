import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//var str = "GSD Semaphores"
//
//let queue = DispatchQueue(label: "Label", attributes: .concurrent)
//
//let semaphore = DispatchSemaphore(value: 2)
//
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 1")
//    semaphore.signal() // +1
//}
//
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 2")
//    semaphore.signal() // +1
//}
//
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 3")
//    semaphore.signal() // +1
//}
//
//let sem = DispatchSemaphore(value: 2)
//
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait(timeout: DispatchTime.distantFuture)
//    sleep(1)
//    print("Block", String(id))
//
//    sem.signal()
//}

class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    var array = [Int]()
    
    func methodWork(_ id: Int) {
        semaphore.wait() // - 1
        
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 2)
        semaphore.signal() // + 1
    }
    
    func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(23231)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(434351)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(5351)
            print(Thread.current)
        }
    }
}

let semaphoreTest = SemaphoreTest()

semaphoreTest.startAllThread()

