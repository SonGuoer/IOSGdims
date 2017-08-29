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
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    
    @IBAction func touchupInsidePostRequestBtnAction(_ sender: AnyObject) {
        let parameters = [
            "mobile": "15702323457",
            "imei": "0"
            ] as [String : Any]
        Alamofire.request("http://183.230.108.112:8099/meteor/findMacro.do",method:.post, parameters: parameters)
            .responseJSON { response in
                print("original URL request: \(String(describing: response.request))")  // original URL request
                print("URL response: \(String(describing: response.response))") // URL response
                print("server data: \(String(describing: response.data))")     // server data
                print("result of response serialization: \(response.result)")   // result of response serialization
                switch response.result {
                case .success:
                    if let values = response.result.value {
                    let json = JSON(values)
                        let info = json["info"].string!
                        let code = json["code"].string!
                        let result = json["result"].string!
                        
                        if let jsonData = info.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                            let json = JSON(data: jsonData)
                            if let number = json[0]["name"].string {
                                // 找到电话号码
                                print("第一个联系人的第一个电话号码：",number)
                            }
                            if let maros = json[1]["name"].string{
                                print("maros数据：",maros)
                            }
                        }
                        
                        print("info:"+info+"code"+code+"result"+result)
                        
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


}

