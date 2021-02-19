//
//  ViewController.swift
//  KeyAttestation
//
//  Created by Sergey Pugach on 10.02.21.
//

import UIKit
import Security
import CryptoKit


class MyClass1 {
    deinit {
        print("class deinit")
    }
}

//struct MyStruct {
//    let cl = MyClass1()
//}

enum TestEnum {
    case cl(MyClass1)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cl = MyClass1()
        let st = TestEnum.cl(cl)
    }
}

