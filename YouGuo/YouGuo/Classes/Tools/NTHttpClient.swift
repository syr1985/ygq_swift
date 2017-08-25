//
//  NTHttpClient.swift
//  YouGuo
//
//  Created by YM on 2017/7/27.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}


class NTHttpClient: NSObject {
    class func getMD5String(param: [String : Any], urlString: String) -> String {
        let sortDict = param.sorted { (dict1, dict2) -> Bool in
            return (dict1.key).localizedStandardCompare(dict2.key) == ComparisonResult.orderedAscending
        }
        
        //print("sortDict : \(sortDict)");
        var paramString = "";
        for (key, value) in sortDict {
            if key != "sign" {
                let dictToString = String.init(format: "%@=%@", key, value as! String);
                paramString = paramString.appending(dictToString);
            }
        }
        //print("paramString : \(paramString)");
        
        let signString = paramString.appending("newtouch");
        let signOfPath = urlString.appending(signString);
        //print("signOfPath : \(signOfPath)")
        
        return md5String(str: signOfPath);
    }
    
    class func md5String(str : String) -> String {
        let cStr = str.cString(using:.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02X", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any], success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let md5String = getMD5String(param : parameters, urlString : URLString);
        //print("md5String : \(md5String)");
        var newParam = parameters;
        newParam.updateValue(md5String, forKey: "sign");
        newParam.updateValue("1", forKey: "version");
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let ServerUrl = "http://119.23.204.218:8080/YGQ"
        let InterfaceUrl = ServerUrl.appending(URLString);
        let dataRequest = Alamofire.request(InterfaceUrl, method: method, parameters: newParam).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    let result = value["result"] as! String
                    if result == "000" {
                        success(value)
                    }
                    //print("value:\(value)")
                }
            case .failure(let error):
                failure(error)
                //print("error:\(error)")
            }
        }
        return dataRequest;
    }
    
    //MARK: - Get 请求
    class func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let dataRequest = Alamofire.request(urlString, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    success(value as! [String : AnyObject])
                    //print("value:\(value)")
                case .failure(let error):
                    failure(error)
                    //print("error:\(error)")
            }
        }
        return dataRequest;
    }
    
    //MARK: - POST 请求
    class func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
       let dataRequest = Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    let result = value["result"] as! String;
                    if result == "000" {
                        success(value)
                    }
                    //print("value:\(value)")
                }
            case .failure(let error):
                failure(error)
                //print("error:\(error)")
            }
        }
        return dataRequest;
    }
    
    //MARK: - 照片上传
    class func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failure : @escaping (_ error : Error)->()) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
//                    let flag = params["flag"]
//                    let userId = params["userId"]
//                    
//                    multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
//                    multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                    for i in 0..<data.count {
                        multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                    }},
            to: urlString,
            headers: ["content-type":"multipart/form-data"],
            encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let value = response.result.value as? [String: AnyObject]{
                                success(value)
                            }
                        }
                    case .failure(let encodingError):
                        failure(encodingError)
                    }
            }
        )
    }
}

