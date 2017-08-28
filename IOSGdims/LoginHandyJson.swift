//
//  LoginHandyJson.swift
//  IOSGdims
//
//  Created by 李青松 on 2017/8/28.
//  Copyright © 2017年 name. All rights reserved.
//

import Foundation
import HandyJSON

class LoginHandyJson: HandyJSON {
    var info: String!
    var code: String!
    var result: String!
    
    //必须实现
    required init() {
        
    }
}

class LoginHandyJsonList: HandyJSON {
    //数组list
    var list: [LoginHandyJson]! = []
    
    //必须实现
    required init() {
        
    }
}
