import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Operation and Operation Queue"

//print(Thread.current)

//let operation1 = {
//    print("Start")
//    print(Thread.current)
//    print("Finish")
//}
//
//let  queue = OperationQueue()
//queue.addOperation(operation1)

//print(Thread.current)
//
//var result: String?
//let concatOperation = BlockOperation {
//    result = "Result"
//    print(Thread.current)
//}
//
////concatOperation.start()
////
////print(result!)
//
//let queue = OperationQueue()
//queue.addOperation(concatOperation)
//
//print(result!)
//
//print(Thread.current)
//let queue1 = OperationQueue()
//queue1.addOperation {
//    print("test")
//    print(Thread.current)
//}

//class MyThread: Thread {
//    override func main() {
//        print("Test main thread")
//    }
//}
//
//let myThread = MyThread()
//myThread.start()
//print(Thread.current)
//
//class OperationA: Operation {
//    override func main() {
//        print("Test operation A")
//        print(Thread.current)
//    }
//}
//
//let operationA = OperationA()
////operationA.start()
//
//let queue1 = OperationQueue()
//queue1.addOperation(operationA)

let operationQueue = OperationQueue()

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 2")
    }
}

func cancelOperationMethod() {
    let cancelOperation = OperationCancelTest()
    operationQueue.addOperation(cancelOperation)
    cancelOperation.cancel()
}
//cancelOperationMethod()

class WaitOperationTest {
    private let opertionQueue = operationQueue
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("Test 1")
        }
        operationQueue.addOperation {
            sleep(1)
            print("Test 2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("Test 3")
        }
        operationQueue.addOperation {
            print("Test 4")
        }
}
}

let waitOperationTest = WaitOperationTest()
//waitOperationTest.test()

class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print("test 1")
        }
        let operation2 = BlockOperation {
            sleep(2)
            print("test 2")
        }
        
        operationQueue.addOperations([operation1,operation2], waitUntilFinished: true)
        
        let operation3 = BlockOperation {
            sleep(1)
            print("test 3")
        }
        let operation4 = BlockOperation {
            sleep(2)
            print("test 4")
        }
    }
}

let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest.test()

class CompletionBlockTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            print("test CompletionBlock")
        }
        operation1.completionBlock = {
            print("finish completionBlock")
        }
        operationQueue.addOperation(operation1)
    }
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()
