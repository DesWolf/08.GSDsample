import UIKit


// Unix - POSIX - низкоуровневневое программирование на Си
var thread = pthread_t(bitPattern: 0) // создаем поток
var attribut = pthread_attr_t()

pthread_attr_init(&attribut) // присваиваем потоку атрибут
pthread_create(&thread, &attribut, { (pointer) -> UnsafeMutableRawPointer? in // открываем поток
    print("test") //сам код
    return nil
}, nil)


// Tread - потоки на Obj-C
var nsThread = Thread {  // создаем поток
    print("test2")
}

nsThread.start// запускаем поток
nsThread.cancel() // останавливаем поток


// Unix - POSIX - низкоуровневневое программирование на Си : приоритеты
var pthread2 = pthread_t(bitPattern: 0)
var attribute2 = pthread_attr_t()

pthread_attr_init(&attribute2)
pthread_attr_set_qos_class_np(&attribute2 , QOS_CLASS_USER_INITIATED, 0)
pthread_create(&pthread2, &attribute2, { (pointer) -> UnsafeMutableRawPointer? in
    print("test3")
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)


// Tread - потоки на Obj-C: приоритеты
let nsThread2 = Thread {
    print("test4")
    print(qos_class_self())
}

nsThread2.qualityOfService = .userInteractive
nsThread2.start()

print(qos_class_main() )
