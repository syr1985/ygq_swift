//
//  NTExtensions.swift
//  YouGuo
//
//  Created by YM on 2017/8/11.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTExtensions: NSObject {

}

extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}

extension String {
    static func sizeOfString(cityName: String, font: UIFont, maxSize: CGSize) -> CGRect {
        let attributes = [NSFontAttributeName:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin//, NSStringDrawingOptions.usesFontLeading]
        let rect:CGRect = cityName.boundingRect(with: maxSize, options: option, attributes: attributes, context: nil)
        return rect
    }
}

extension String {
    static func cropImageUrlWithUrlString(imageUrl: String, width: CGFloat, height: CGFloat) -> String {
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone//UIUserInterfaceIdiomPhone
        let is6P_7P = isPhone && (max(SCREENWIDTH, SCREENHEIGHT) == 736.0)
        let scale = is6P_7P ? 3 : 2
        let paramW = Int(width) * scale
        let paramH = Int(height) * scale
        let newUrl = "\(imageUrl)?imageView2/1/w/\(paramW)/h/\(paramH)/interlace/1"
        return String.urlEncoding(url: newUrl)
    }
    
    static func urlEncoding(url: String) -> String {
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

extension String {
    static func randomString() ->String {
        let chars : String = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLOMNOPQRSTUVWXYZ";
        let randomCount = 5;
        var text = "";
        for _ in 0..<randomCount {
            let index = arc4random_uniform(UInt32(chars.characters.count))
            let nsRange = NSRange(location: Int(index), length: 1)
            let range = chars.range(from: nsRange)
            let subStr = chars.substring(with: range!)
            text = text.appending(subStr);
        }
        return text;
    }
    
    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex)
        let to16 = utf16.index(from16!, offsetBy: nsRange.length)
        let from = String.Index(from16!, within: self)
        let to = String.Index(to16, within: self)
        return from! ..< to!
    }
}

extension Date {
    static func timeSpacing(timeInterval: TimeInterval) -> String {
        let nowDate = Date.init()
        let interval = nowDate.timeIntervalSince1970
        let spacing = Int64(interval - timeInterval / 1000.0)
        //print("\(timeInterval) -- \(interval) -- \(spacing)")
        
        let oneMini : Int64 = 60
        let oneHour : Int64 = oneMini * Int64(60)
        let oneDay  : Int64 = oneHour * Int64(24)
        
        let oneYear : Int64 = oneDay  * Int64(365)
        let years = spacing / oneYear
        if years != 0 {
            return "\(years)年前"
        }
        
        let oneMonth: Int64 = oneDay  * Int64(30)
        let months = spacing / oneMonth
        if months != 0 {
            return "\(months)月前"
        }
        
        let oneWeek : Int64 = oneDay  * Int64(7)
        let weeks = spacing / oneWeek
        if weeks != 0 {
            return "\(weeks)周前"
        }
        
        let days = spacing / oneDay
        if days != 0 {
            return "\(days)天前"
        }
        
        let hours = spacing / oneHour
        if hours != 0 {
            return "\(hours)小时前"
        }
        
        let minits = spacing / oneMini
        if minits > 1 {
            return "\(minits)分钟前"
        }
        
        return "刚刚"
    }
}
