//
//  NTHomeHotModel.swift
//  YouGuo
//
//  Created by YM on 2017/8/8.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import HandyJSON

class NTHomeHotModel: HandyJSON {
    var id : String?
    var sex : String = "男"
    var city : String = ""
    var headImg : String = ""
    var nickName : String = ""
    var coverImgUrl : String = ""
    var star : Int = 0
    var imageCount : Int = 0
    var isRecommend : Bool = false
    
    required init() {};
}
