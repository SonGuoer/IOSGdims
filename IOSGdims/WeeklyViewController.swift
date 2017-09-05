//
//  WeeklyViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/9/4.
//  Copyright © 2017年 name. All rights reserved.
//  工作周报上报功能页面

import UIKit
import SwiftyDrop
import Alamofire
import SwiftyJSON
class WeeklyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var villageName: UITextField!
    @IBOutlet weak var workContent: UITextView!
    @IBOutlet weak var patrollerName: UITextField!
    @IBOutlet weak var reportDate: UILabel!
    /*网络请求管理器*/
    var sessionManager:SessionManager?
    /*share*/
    var userDefault = UserDefaultUtils()
    var getTime = GetTimeUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportDate.text=getTime.getTimes()
        villageName.delegate = self
        patrollerName.delegate = self
    }

    
    
    @IBAction func weeklyPost(_ sender: Any) {
     
        if isText(){
            let url = Api.init().postWeeklyUrl()
            let dic:[String:String] = ["member":""
                ,"phoneNum":userDefault.getUser(forKey: "phoneNum")!
                ,"units":villageName.text!
                ,"userName":patrollerName.text!
                ,"jobContent":workContent.text!]

            weekPost(url: url, dic: dic)
//             POST(url: url, dic: dic)
        }
    }
    
    func isText()-> Bool{
        let villageNames = villageName.text!
        let workContents = workContent.text!
        let patrollerNames = patrollerName.text!
        
        if villageNames.isEmpty {
            Drop.down("村镇名称不能为空" ,state:.error)
            return false
        }
        else if patrollerNames.isEmpty {
            Drop.down("村级巡查员不能为空",state:.error)
            return false
        }else if workContents.isEmpty {
            Drop.down("工作内容",state:.error)
            return false
        }
        return true
    }
    
      func weekPost(url:String,dic:Dictionary<String, Any>)  {
      
        Drop.down("正在登录请稍后" ,duration:15.0)
        print(url)
        /*需要上传的参数集合*/
        let json = getTime.getJSONStringFromDictionary(dictionary: dic as NSDictionary)
        print(json)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15

        sessionManager = Alamofire.SessionManager(configuration: configuration)
        /*上传的Alamofire方法*/
        sessionManager?.request(url,method:.post, parameters:["data":json] )
            .responseJSON { response in
           print("original URL request: \(String(describing: response.request))")
           print("URL response: \(String(describing: response.response))") // URL
                switch response.result {
                case .success:
                    if let values = response.result.value {
                        print(values)
                        let json = JSON(values)
                        let message = json["message"].string!
                        let status = json["status"].int!
                        if status == 200{
                            Drop.down(message ,state:.success ,duration:1.0)
                        }else{
                            Drop.down(message ,state:.error ,duration:3.0)
                        }
                        
                        self.view.isUserInteractionEnabled = true
                    }
                case .failure(let error):
                    print(error)
                    Drop.down("上传失败,请检查网络信息", state: .error)
                    self.view.isUserInteractionEnabled = true
                }
                
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        villageName.resignFirstResponder()
        patrollerName.resignFirstResponder()
        workContent.resignFirstResponder()
   
    }
    

}
