//
//  ViewController.swift
//  tddchat
//
//  Created by Carlos Matias Tripode on 7/28/18.
//  Copyright © 2018 nashu. All rights reserved.
//

import UIKit
import chatengine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ChatManager.shared.connect(username: "", password: "") { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
