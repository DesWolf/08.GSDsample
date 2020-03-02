import UIKit

var str = "NSRecursiveLock"

// C
//let recursiveLock = NSRecursiveLock()

class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }
    
    func firstTask() {
        pthread_mutex_lock(&mutex)
        secondTask()
        defer{
            pthread_mutex_unlock(&mutex)
        }
    }
    
    func secondTask() {
        pthread_mutex_lock(&mutex)
        print("Finish")
        defer{
            pthread_mutex_unlock(&mutex)
        }
    }
}

let recurcive = RecursiveMutexTest()
recurcive.firstTask()

// Obj-C
let recursiveLock = NSRecursiveLock() // если написать NSLock то сработает блокировка и callMe не вызывается

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        print("Thread acquired lock")
        callMe()
        defer {
            recursiveLock.unlock()
        }
        print("Exit main")
    }
    
    func callMe() {
        recursiveLock.lock()
        print("Thread acquired lock")
        defer{
            recursiveLock.unlock()
        }
        print("Exit callMe")
    }
}

let tread = RecursiveThread()
tread.start()


