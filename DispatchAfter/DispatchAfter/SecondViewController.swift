//
//  SecondViewController.swift
//  DispatchAfter
//
//  Created by Максим Окунеев on 3/4/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0...200000 {
//            print(i)
//        }
//
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 20000) {
//                print("\($0) times")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Dev", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async{
            print("Done!")
        }
        print("not yet started...")
        inactiveQueue.activate()
        print("Activate!")
        inactiveQueue.suspend()
        print("Pause")
        inactiveQueue.resume()
}
}

    

