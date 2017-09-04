//
//  WeeklyViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/9/4.
//  Copyright © 2017年 name. All rights reserved.
//  工作周报上报功能页面

import UIKit

class WeeklyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var villageName: UITextField!
    @IBOutlet weak var workContent: UITextView!
    @IBOutlet weak var patrollerName: UITextField!
    @IBOutlet weak var reportDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
