//
//  ViewController.swift
//  DispatchAfter
//
//  Created by Максим Окунеев on 3/4/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        afterBlock(seconds: 4, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
//        afterBlock(seconds: 4) {
//            print("Hello")
//            self.showAlert()
//            print(Thread.current)
//        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "AAAA!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.main,  complition: @escaping()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }

}















