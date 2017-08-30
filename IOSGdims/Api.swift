//
//  Api.swift
//  IOSGdims
//
//  Created by 李青松 on 2017/8/29.
//  Copyright © 2017年 name. All rights reserved.
//

import Foundation

class Api{
    var ip = ""
    var port = ""
    var userDefault = UserDefaultUtils()
    init() {
        self.ip = userDefault.getUser(forKey: "ips")!
        self.port = userDefault.getUser(forKey: "ports")!
    }
    
    func getLoginUrl() -> String{
        let url = "http://"+ip+":"+port+"/meteor/findFunCfg.do"
        return url
    }
    
}
