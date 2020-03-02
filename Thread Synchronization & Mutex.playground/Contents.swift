import UIKit

// Синхронизация и безопасность потоков

var str = "Synchronization & Mutex"

//C
class SaveThreaad {
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(competion: () -> ()) {
        pthread_mutex_lock(&mutex)
        competion()
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}

var array = [String]()
let saveThread = SaveThreaad()

saveThread.someMethod {
    print("test")
    array.append("1 thread")
}

array.append("2 thread")

//Obj-C
class SaveThreaad2 {
    private var lockMutex = NSLock()
    
    func someMethod(competion: () -> ()) {
        lockMutex.lock()
        competion()
        defer {
            lockMutex.unlock()
        }
    }
}

var array2 = [String]()
let saveThread2 = SaveThreaad()

saveThread2.someMethod {
    print("test2")
    array2.append("1 thread")
}

array2.append("2 thread")
