//
//  CellModel.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/8/30.
//  Copyright © 2017年 name. All rights reserved.
//  自定义Cell

import UIKit

class CellModel: NSObject {
    
    var id: String
    var image: String
    var title: String
    
    init(id: String, image: String, title: String) {
        self.id = id
        self.image = image
        self.title = title
    }
}
