//
//  NTNetworkTool.swift
//  YouGuo
//
//  Created by YM on 2017/7/28.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import Alamofire

class NTNetworkTool: NSObject {
    class func login(phoneNum: String, password: String, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : NSMutableDictionary = NSMutableDictionary.init();
        muDict["requestseq"]    = String.randomString();
        muDict["sign"]          = "";
        muDict["mobile"]        = phoneNum;
        muDict["passwd"]        = password;
        muDict["loginFrom"]     = "ios";
        
        let urlString = "/iface/appuser/loginmobile";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict as! [String : Any], success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
    
    class func register(phoneNum: String, password: String, nickName: String, sex: String, city: String, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : NSMutableDictionary = NSMutableDictionary.init();
        muDict["requestseq"] = String.randomString();
        muDict["sign"]       = "";
        muDict["mobile"]     = phoneNum;
        muDict["passwd"]     = password;
        muDict["nickName"]   = nickName;
        muDict["sex"]        = sex;
        muDict["city"]       = city;
        
        let urlString = "/iface/appuser/registermobile";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict as! [String : Any], success: { (retValue : [String : AnyObject]) in
            success(retValue);
        }) { (error : Error) in
            failure(error);
        }
        return dataRequset;
    }
    
    class func resetPwd(phoneNum: String, password: String, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : NSMutableDictionary = NSMutableDictionary.init();
        muDict["requestseq"] = String.randomString();
        muDict["sign"]       = "";
        muDict["mobile"]     = phoneNum;
        muDict["passwd"]     = password;
        
        let urlString = "/iface/appuser/resetpwd";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict as! [String : Any], success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
    
    class func getAuthCode(phoneNum: String, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : NSMutableDictionary = NSMutableDictionary.init();
        muDict["requestseq"]  = String.randomString();
        muDict["sign"]        = "";
        muDict["mobile"]      = phoneNum;
        muDict["isResetPass"] = "";
        
        let urlString = "/iface/appuser/getVerifiCode";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict as! [String : Any], success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
    
    class func getHomeHotData(pageNo: Int, pageSize: Int, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : [String : Any] = ["requestseq" : String.randomString(),
                                       "sign"       : "",
                                       "pageNo"     : "\(pageNo)",
                                       "pagesize"   : "\(pageSize)"];
        
        let urlString = "/iface/appuser/homePageList";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict, success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
    
    class func getHomeVideoData(pageNo: Int, pageSize: Int, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : [String : Any] = ["requestseq" : String.randomString(),
                                       "sign"       : "",
                                       "pageNo"     : "\(pageNo)",
                                       "pagesize"   : "\(pageSize)"];
        
        let urlString = "/iface/feeds/recommendVideoList";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict, success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }

    class func getHomeFocusData(pageNo: Int, pageSize: Int, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : [String : Any] = [ "requestseq" : String.randomString(),
                                        "sign"       : "",
                                        "pageNo"     : "\(pageNo)",
                                        "pagesize"   : "\(pageSize)",
                                        "fromUserId" : NTLoginModel.sharedInstance.id];
        
        let urlString = "/iface/feeds/homepageFocuslist";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict, success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
    
    class func getRecommendData(pageNo: Int, pageSize: Int, success : @escaping (_ response : [String: AnyObject])->(), failure : @escaping (_ error : Error)->()) -> DataRequest {
        let muDict : [String : Any] = [ "requestseq" : String.randomString(),
                                        "sign"       : "",
                                        "pageNo"     : "\(pageNo)",
                                        "pagesize"   : "\(pageSize)",
                                        "fromUserId" : NTLoginModel.sharedInstance.id];
        
        let urlString = "/iface/feeds/homepageFocuslist";
        let dataRequset = NTHttpClient.requestData(.post, URLString: urlString, parameters: muDict, success: { (retValue : [String: AnyObject]) in
            success(retValue);
        }, failure: { (error : Error) in
            failure(error);
        });
        return dataRequset;
    }
}

