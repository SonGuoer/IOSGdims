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
    var ips = ""
    var ports = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ipText.delegate = self
        portText.delegate = self
        
    }
    @IBAction func phoneNumChange(_ sender: Any) {
        
        if (self.phoneNumText.text?.characters.count)!>11{
            Drop.down("号码不能超过11位")
        }
    }
    @IBAction func touchupInsidePostRequestBtnAction(_ sender: Any) {
        //获取人员类型的值
        let typeNumber = String(personType.selectedSegmentIndex)
        /*获取输入框文本*/
        let phoneNum = phoneNumText.text!
         ips = ipText.text!
         ports = portText.text!
        if phoneNum.isEmpty {
            Drop.down("号码不能为空")
        }else if ips.isEmpty {
             Drop.down("ip不能为空")
        }else if ports.isEmpty {
            Drop.down("端口不能为空")
        }else{
            //启动网络请求
           loginPost(phone: phoneNum , imei: typeNumber)
        }
        
      
    }
    func loginPost(phone:String,imei:String)  {
        /*需要上传的参数集合*/
        let parameters = [
            "mobile": phone,
            "imei":imei
            ] as [String : Any]
        /*上传的Alamofire方法*/
        Alamofire.request("http://"+ips+":"+ports+"/meteor/findMacro.do",method:.post, parameters: parameters)
            .responseJSON { response in
//                print("original URL request: \(String(describing: response.request))")  // original URL request
//                print("URL response: \(String(describing: response.response))") // URL response
//                print("server data: \(String(describing: response.data))")     // server data
//                print("result of response serialization: \(response.result)")   // result of response serialization
                switch response.result {
                case .success:
                    if let values = response.result.value {
                        let json = JSON(values)
                        let info = json["info"].string!
//                        let code = json["code"].string!
                        let result = json["result"].string!
                        if result == "1" {
                            
                            if info == "[]"{
                                Drop.down("没有查到该号码对应的群测群防人员", state: .error)
                            }else{
                           
                                Drop.down("登录成功", state: .success)
                            }
                        }else{
                           Drop.down(info, state: .error)
                        }
//                        if let jsonData = info.data(using: String.Encoding.utf8, allowLossyConversion: false) {
   
                    }
                case .failure(let error):
                    print(error)
                }
        
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

