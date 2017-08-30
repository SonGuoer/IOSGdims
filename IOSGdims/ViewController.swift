//
//  ViewController.swift
//  IOSGdims
//
//  Created by 李青松 on 2017/8/24.
//  Copyright © 2017年 name. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SwiftyJSON
import SwiftyDrop
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ipText: UITextField!
    @IBOutlet weak var portText: UITextField!
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var personType: UISegmentedControl!
    @IBOutlet weak var loginBtn: UIButton!
    var ips = "192.168.1.1"
    var ports = "8080"
    var phoneNum = "110"
    var activityIndicator:UIActivityIndicatorView!
    var sessionManager:SessionManager?
    var userDefault = UserDefaultUtils()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ipText.delegate = self
        portText.delegate = self
        
        if ((userDefault.getUser(forKey: "isSave") as String!) != nil) {
            self.phoneNumText.text = userDefault.getUser(forKey: "phoneNum")
            self.ipText.text = userDefault.getUser(forKey: "ips")
            self.portText.text = userDefault.getUser(forKey: "ports")
         }
 
        
    }
    @IBAction func phoneNumChange(_ sender: Any) {
        
        if (self.phoneNumText.text?.characters.count)!>11{
            Drop.down("号码不能超过11位")
        }
    }
    /*登录按钮监听*/
    @IBAction func touchupInsidePostRequestBtnAction(_ sender: Any) {
        //获取人员类型的值
        let typeNumber = String(personType.selectedSegmentIndex)
        /*获取输入框文本*/
         phoneNum = phoneNumText.text!
         ips = ipText.text!
         ports = portText.text!
        /*设置存储信息*/
         userDefault.putUser(text: phoneNum, forKey: "phoneNum")
         userDefault.putUser(text:ips, forKey: "ips")
         userDefault.putUser(text:ports, forKey: "ports")
         userDefault.putUser(text:typeNumber, forKey: "typeNumber")
         userDefault.putUser(text:"true", forKey: "isSave")
    
        if phoneNum.isEmpty {
            Drop.down("号码不能为空" ,state:.error)
        }else if ips.isEmpty {
             Drop.down("ip不能为空",state:.error)
        }else if ports.isEmpty {
            Drop.down("端口不能为空",state:.error)
        }else{
            //启动网络请求
           loginPost(phone: phoneNum , imei: typeNumber)
        }
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      /*
     回收系统键盘
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     点击空白处收起keyboard
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumText.resignFirstResponder()
    }
    
}

