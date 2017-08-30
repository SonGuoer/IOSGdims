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
    init() {
        self.ip = UserDefaults.standard.value(forKey: "ips") as! String!
        self.port = UserDefaults.standard.value(forKey: "ports") as! String!
    }
    
    func getLoginUrl() -> String{
        let url = "http://"+ip+":"+port+"/meteor/findFunCfg.do"
        return url
    }
    
}
