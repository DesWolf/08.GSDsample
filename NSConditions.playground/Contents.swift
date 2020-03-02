import UIKit

var str = "NSCondition()"

var avaliable = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class ContionMutexPrinter: Thread { // Второй поток
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        while(!avaliable) {
            pthread_cond_wait(&condition, &mutex)
        }
        avaliable = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Printer exit")
    }
}

class ContionMutexWriter: Thread { // Первый поток
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        avaliable = true
        pthread_cond_signal(&condition) // сигнал о том что можно активиковать поток №2
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer exit")
    }
}

let contionMutexWriter = ContionMutexWriter()
let contionMutexPrinter = ContionMutexPrinter()

//contionMutexPrinter.start()
// contionMutexWriter.start()


// работа с NSCondition
var сondition2 = NSCondition()
var avaliable2 = false

class WriterThread: Thread {
   
    override func main() {
        //main
        сondition2.lock()
        print("WriterThread enter")
        avaliable2 = true
        сondition2.signal()
        сondition2.unlock()
        print("WriterThread exit")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        сondition2.lock()
        print("PrinterThread enter")
        while(avaliable2 != true) {
            сondition2.wait()
        }
        avaliable2 = false
        сondition2.unlock()
        print("PrinterThread exit")
    }
}

let nswriter = WriterThread()
let nsprinter = PrinterThread()

nsprinter.start()
nswriter.start()

