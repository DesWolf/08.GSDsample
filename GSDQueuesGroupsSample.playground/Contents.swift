import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent)
let group = DispatchGroup()

queue.async (group: group){
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async (group: group){
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("All done in groupe: group")
}

let secondGroupe = DispatchGroup()
secondGroupe.enter()
queue.async {
    for i in 0...30 {
        if i == 30 {
            print(i)
            sleep(2)
            secondGroupe.leave()
        }
    }
}

let result = secondGroupe.wait(timeout: .now() + 1)
print(result)

secondGroupe.notify(queue: .main) {
    print("All done in groupe: secondGroupe")
}

print("This text is upper then previous")

secondGroupe.wait() // пока не выполнился код secondGroupe дальше выполнение кода не пойдет
