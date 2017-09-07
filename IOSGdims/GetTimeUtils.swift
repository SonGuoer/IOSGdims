//
//  GetTimeUtils.swift
//  IOSGdims
//
//  Created by 李青松 on 2017/9/4.
//  Copyright © 2017年 name. All rights reserved.
//

import Foundation

class GetTimeUtils{
    init() {
        
    }
    /*获取时间*/
    func getTimes() -> String  {
        
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        
        return strNowTime;
    }
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
}
