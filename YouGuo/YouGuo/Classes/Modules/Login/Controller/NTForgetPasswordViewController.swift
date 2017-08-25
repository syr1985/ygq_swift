//
//  NTForgetPasswordViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/27.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import SVProgressHUD

class NTForgetPasswordViewController: NTBaseViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var authcodeTextField: UITextField!
    @IBOutlet weak var newpwdTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    fileprivate var authCode : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        
        let padding = UIEdgeInsetsMake(5, 10, 5, 0);
        let phoneLeftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 46, height: 36));
        let phoneLabel = UILabel.init();
        phoneLabel.text = "+86";
        phoneLabel.minimumScaleFactor = 0.5;
        phoneLabel.adjustsFontSizeToFitWidth = true;
        phoneLabel.textColor = UIColor.black;
        phoneLabel.font = UIFont.init(name: "STHeiti", size: 14);
        phoneLeftView.addSubview(phoneLabel);
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(phoneLeftView).inset(padding);
        }
        self.phoneTextField.leftView = phoneLeftView;
        self.phoneTextField.leftViewMode = .always;
        self.phoneTextField.layer.borderWidth = 1;
        self.phoneTextField.layer.cornerRadius = 5;
        self.phoneTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.authcodeTextField.layer.borderWidth = 1;
        self.authcodeTextField.layer.cornerRadius = 5;
        self.authcodeTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.newpwdTextField.layer.borderWidth = 1;
        self.newpwdTextField.layer.cornerRadius = 5;
        self.newpwdTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.confirmTextField.layer.borderWidth = 1;
        self.confirmTextField.layer.cornerRadius = 5;
        self.confirmTextField.layer.borderColor = ViewBorderColor.cgColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getAuthCodeAction(_ sender: SwiftCountdownButton) {
        if self.phoneTextField.text?.characters.count == 0 {
            SVProgressHUD.showInfo(withStatus: "请输入注册手机号");
            return;
        }
        
        if self.phoneTextField.text?.characters.count != 11 {
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号");
            return;
        }
        
        sender.countdown = true;
        
        // 获取验证码
        _ = NTNetworkTool.getAuthCode(phoneNum: self.phoneTextField.text!, success: { (retValue) in
            self.authCode = retValue["verifiCode"] as! String;
        }) { (error) in
            SVProgressHUD.showInfo(withStatus: "\(error.localizedDescription)")
        }
    }
    
    
    @IBAction func sureModifyPasswordAction(_ sender: Any) {
        if self.authCode != self.authcodeTextField.text {
            SVProgressHUD.showInfo(withStatus: "验证吗不正确");
            return;
        }
        
        if self.newpwdTextField.text?.characters.count == 0  {
            SVProgressHUD.showInfo(withStatus: "请输入新密码");
            return;
        }
        
        if self.newpwdTextField.text != self.confirmTextField.text {
            SVProgressHUD.showInfo(withStatus: "两次输入密码不一致");
            return;
        }
        
        _ = NTNetworkTool.resetPwd(phoneNum: self.phoneTextField.text!, password: self.newpwdTextField.text!, success: { (retValue) in
            SVProgressHUD.showSuccess(withStatus: "密码修改成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.navigationController?.popViewController(animated: true);
            });
        }) { (error) in
            SVProgressHUD.showInfo(withStatus: "\(error.localizedDescription)")
        }
    }
    
//    override func popViewController() {
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
