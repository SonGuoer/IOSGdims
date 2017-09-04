//
//  DailyReportViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/9/1.
//  Copyright © 2017年 name. All rights reserved.
//  日志上报功能页面

import UIKit
import SwiftyDrop
import SwiftyJSON
import Alamofire

class DailyReportViewController: UIViewController {
    /*记录时间*/
    @IBOutlet weak var time: UILabel!
    /*记录人员*/
    @IBOutlet weak var recordClerk: UITextField!
    /*工作类型*/
    @IBOutlet weak var workType: UITextField!
    /*在岗情况*/
    @IBOutlet weak var postSituation: UITextField!
    /*日志内容*/
    @IBOutlet weak var logContent: UITextView!
    /*备注*/
    @IBOutlet weak var remarks: UITextView!
    /*网络请求管理器*/
    var sessionManager:SessionManager?
    /*share*/
    var userDefault = UserDefaultUtils()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*获取时间*/
    func getTimes() -> String  {
        
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        
        return strNowTime;
    }
    

    @IBAction func logReport(_ sender: Any) {
         let url=Api.init().postReportUrl()
        let phoneNum = userDefault.getUser(forKey: "phoneNum")!
        if isText() {
            logPost(url:url,phoneNum:phoneNum)
            //禁用页面
            self.view.isUserInteractionEnabled = false
        }
        
    
    }
    
    @IBAction func saveDate(_ sender: Any) {
        if isText() {
            Drop.down("数据齐全")
        }

    }
    func isText()-> Bool{
        let recordClerks = recordClerk.text!
        let workTypes = workType.text!
        let postSituations = postSituation.text!
        let logContents = logContent.text!
        print("内容："+logContents)
        let remark = remarks.text!
        
        if recordClerks.isEmpty {
            Drop.down("记录人员不能为空" ,state:.error)
            return false
        }else if workTypes.isEmpty {
            Drop.down("工作类型不能为空",state:.error)
            return false
        }else if remark.isEmpty {
            Drop.down("备注不能为空",state:.error)
            return false
        }else if logContents.isEmpty {
            Drop.down("日志内容不能为空",state:.error)
            return false
        }else if postSituations.isEmpty {
            Drop.down("在岗情况不能为空",state:.error)
            return false
        }
        return true
    }
    
    func logPost(url:String,phoneNum:String)  {
       
        Drop.down("正在登录请稍后" ,duration:15.0)
        
        /*需要上传的参数集合*/
        let parameters = ["userName": recordClerk.text!,"workType":workType.text! ,
                          "situation": postSituation.text!
            ,"logContent": logContent.text!
            ,"remarks":remarks.text!
            ,"recordTime":time.text!
            ,"phoneNum":phoneNum] as [String : Any]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        /*上传的Alamofire方法*/
        sessionManager?.request(url,method:.post, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let values = response.result.value {
                        print(values)
                        let json = JSON(values)
                        let message = json["message"].string!
                        //let code = json["code"].string!
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

}
