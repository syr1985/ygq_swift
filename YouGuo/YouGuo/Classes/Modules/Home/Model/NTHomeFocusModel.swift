//
//  NTHomeFocusModel.swift
//  YouGuo
//
//  Created by YM on 2017/8/9.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import HandyJSON

class NTHomeFocusModel: HandyJSON {
    var id : String?
    var feedsType : Int = 1
    var sex : String = ""
    var star : Int = 0
    var audit : Int = 0
    var userId : String = ""
    var headImg : String = ""
    var nickName : String = ""
    
    var price : Int = 0
    var instro : String = ""
    var goodsId : String = ""
    var imageUrl : String = ""
    var videoUrl : String = ""
    var goodsName : String = ""
    
    var timeLineId : String = ""
    var createTime : TimeInterval = 0
    var updateTime : TimeInterval = 0
    var auditResult : String = ""
    var videoEvelope : String = ""

    var buyCount : Int16 = 0
    var playTimes : Int16 = 0
    var commentCount : Int16 = 0
    var recommendCount : Int16 = 0
    var buyCommentGoodCount : Int16 = 0
    
    var isBuy : Bool = false
    var isMyZan : Bool = false
    var isRecommend : Bool = false
    //var cellHeight : Float = 0
    
    required init() {};
    
    func cellHeight() -> CGFloat {
        let font = UIFont.init(name: "STHeiti", size: 14)
        let size = CGSize.init(width: SCREENWIDTH - 24, height: 0)
        if feedsType == 1 || feedsType == 4 {
            let titleH = String.sizeOfString(cityName: instro, font: font!, maxSize: size).height
            var maxH = titleH + 112
            if imageUrl.characters.count != 0 {
                let margin = 6
                var defaultW = (SCREENWIDTH - CGFloat(24 - 2 * margin)) / CGFloat(3)
                if imageUrl.contains(";") {
                    let urlArray = imageUrl.components(separatedBy: ";")
                    let count = urlArray.count
                    let row = (count % 3 == 0 ? (count / 3) : (count / 3 + 1))
                    maxH += (CGFloat(row) * defaultW + CGFloat((row - 1) * margin));
                } else {
                    defaultW = 178
                    maxH += defaultW
                }
            }
            return maxH
        } else if feedsType == 2 {
            let titleH = String.sizeOfString(cityName: instro, font: font!, maxSize: size).height
            let imageH = (SCREENWIDTH - 24) * 185 / 320;
            return titleH + imageH + 112
        } else {
            let titleH = String.sizeOfString(cityName: goodsName, font: font!, maxSize: size).height
            let imageH = (SCREENWIDTH - 24) * 216 / 350;
            return titleH + imageH + 112
        }
    }
}
