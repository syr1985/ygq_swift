//
//  NTLoginModel.swift
//  YouGuo
//
//  Created by YM on 2017/7/29.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import HandyJSON

class NTLoginModel : HandyJSON {
    var id              : String = "";
    var headImg         : String = "";
    var nickName        : String = "";
    var zfbAccount      : String = "";
    var realName        : String = "";
    var auditResult     : String!;
    var hxu             : String!;
    var hxp             : String!;
    var ymu             : String!;
    var phone           : String!;
    var audit           = 0;
    var star            = 0;
    var isRecommend     = false;
    var havePublishWX   = false;
    var publishWX       = "";
    var publishWXPrice  = "";
    
    static var sharedInstance = NTLoginModel();
    
    required init() {};
}
