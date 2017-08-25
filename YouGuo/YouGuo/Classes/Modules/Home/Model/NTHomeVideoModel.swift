//
//  NTHomeVideoModel.swift
//  YouGuo
//
//  Created by YM on 2017/8/8.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import HandyJSON

class NTHomeVideoModel: HandyJSON {
    var id : String? 
    var sex : String = "男"
    var star : Int = 0
    var city : String = ""
    var userId : String = ""
    var duration : String = ""
    var nickName : String = ""
    var videoEvelope : String = ""
    
    required init() {};
}
