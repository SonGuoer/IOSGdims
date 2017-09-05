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
    var ports = ""
    var userDefault = UserDefaultUtils()
    init() {
        self.ip = userDefault.getUser(forKey: "ips")!
        self.port = userDefault.getUser(forKey: "ports")!
         self.ports = "8090";
    }
    
    func getLoginUrl() -> String{
        let url = "http://"+ip+":"+port+"/meteor/findFunCfg.do"
        return url
    }
    func postReportUrl() -> String{
        let url = "http://"+ip+":"+ports+"/meteor/DailyApp/saveWorkLog.do"
        return url
    }
    //   周报上报
    func postWeeklyUrl() -> String{
        let url = "http://"+ip+":"+ports+"/meteor/DailyApp/saveWeekLog.do"
        return url
    }

    
    //   村级巡查周报上报
    func postVillageWeeklyUrl() -> String{
         return "http://" + ip + ":" + ports+"/meteor/addYyVillageReport.do";
    }

    
   }
