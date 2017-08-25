//
//  NTLoginTool.swift
//  YouGuo
//
//  Created by YM on 2017/7/29.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import HandyJSON
import SVProgressHUD

class NTLoginTool: NSObject {
    class func login(param: [String : Any], show: Bool) {
        if show {
            SVProgressHUD.show(withStatus: "登录")
        }
        let phone = param["phone"] as! String
        let password = param["password"] as! String
        _ = NTNetworkTool.login(phoneNum: phone, password: password, success: { (retValue : [String : AnyObject]) in
            SVProgressHUD.dismiss();
            
            let data : Data = try! JSONSerialization.data(withJSONObject: retValue, options: [])
            let JSONString = String.init(bytes: data, encoding: .utf8)
            let loginModel = JSONDeserializer<NTLoginModel>.deserializeFrom(json: JSONString)
            NTLoginModel.sharedInstance = loginModel!;
            
            //print("\(NTLoginModel.sharedInstance.id)")
            
            var isChangeAccount = false
            let oldPhone = UserDefaults.standard.value(forKey: KEY_USER_PHONE) as? String
            if (oldPhone == nil ||
                oldPhone != phone) {
                isChangeAccount = true;
                
                self.saveLoginData(phone: phone, password: password)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationLoginSuccess),
                                            object: nil,
                                            userInfo: ["ChangeAccount" : isChangeAccount])
            
        }) { (error) in
            SVProgressHUD.showInfo(withStatus: "\(error.localizedDescription)");
        }
    }
    
    class func register(param : [String : Any]) {
        SVProgressHUD.show(withStatus: "注册")
        let phonenum = param["phonenum"] as! String
        let password = param["password"] as! String
        let nickname = param["nickname"] as! String
        let usersex  = param["usersex"]  as! String
        let usercity = param["usercity"] as! String
        _ = NTNetworkTool.register(phoneNum: phonenum, password: password, nickName: nickname, sex: usersex, city: usercity, success: { (retValue : [String : AnyObject]) in
            SVProgressHUD.dismiss();
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                SVProgressHUD.showSuccess(withStatus: "注册成功");
                
                self.login(param: ["phone" : phonenum, "password" : password], show: false)
            })
        }) { (error) in
            SVProgressHUD.dismiss();
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: { 
                SVProgressHUD.showInfo(withStatus: "\(error.localizedDescription)");
            })
        }
    }
    
    class func saveLoginData(phone : String, password : String) {
        UserDefaults.standard.set(phone, forKey: KEY_USER_PHONE)
        UserDefaults.standard.set(password, forKey: KEY_USER_PASSWORD);
        UserDefaults.standard.synchronize()
    }
}
