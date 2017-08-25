//
//  NTSettingAccountViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/26.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class NTSettingAccountViewController: NTBaseViewController , UITextFieldDelegate {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var authcodeTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!
    private var authCode : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        
        let padding = UIEdgeInsetsMake(5, 10, 5, 0);
        let phoneLeftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 46, height: 36));
        let phoneLabel = UILabel.init();
        phoneLabel.text = "+86";
        phoneLabel.font = UIFont.init(name: "STHeiti", size: 14);
        phoneLabel.textColor = UIColor.black;
        phoneLeftView.addSubview(phoneLabel);
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(phoneLeftView).inset(padding);
        }
        self.phoneTextField.leftView = phoneLeftView;
        self.phoneTextField.leftViewMode = .always;
        
        let pwdLeftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 46, height: 36));
        let pwdImageView = UIImageView.init(image: UIImage.init(named: "Password"));
        pwdLeftView.addSubview(pwdImageView);
        pwdImageView.snp.makeConstraints { (make) in
            make.left.equalTo(pwdLeftView).offset(11);
            make.top.equalTo(pwdLeftView).offset(6);
            make.width.equalTo(24);
            make.height.equalTo(24);
        }
        self.passwordTextField.leftView = pwdLeftView;
        self.passwordTextField.leftViewMode = .always;
        
        
        self.nextStepButton.layer.cornerRadius = self.nextStepButton.frame.size.width * 0.5;
        self.nextStepButton.layer.masksToBounds = true;
        
        self.phoneTextField.layer.borderWidth = 1;
        self.phoneTextField.layer.cornerRadius = 5;
        self.phoneTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.authcodeTextField?.layer.borderWidth = 1;
        self.authcodeTextField?.layer.cornerRadius = 5;
        self.authcodeTextField?.layer.borderColor = ViewBorderColor.cgColor;
        
        self.passwordTextField.layer.borderWidth = 1;
        self.passwordTextField.layer.cornerRadius = 5;
        self.passwordTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.confirmTextField.layer.borderWidth = 1;
        self.confirmTextField.layer.cornerRadius = 5;
        self.confirmTextField.layer.borderColor = ViewBorderColor.cgColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countDownAction(_ sender: SwiftCountdownButton) {
        sender.countdown = true;
        
        // 调接口
        // 获取验证码
        _ = NTNetworkTool.getAuthCode(phoneNum: self.phoneTextField.text!, success: { (retValue) in
            self.authCode = retValue["verifiCode"] as! String;
        }) { (error) in
            SVProgressHUD.showInfo(withStatus: "\(error.localizedDescription)")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination;
        if segue.identifier == "VerifyAuthCodeVCSegue" {
            let verifyAuthCodeVC = destVC as? NTRegisterAccountViewController;
            verifyAuthCodeVC?.telephone = self.phoneTextField.text!;
            verifyAuthCodeVC?.passsword = self.passwordTextField.text!;
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "RegisterToPrivacy") {
            return true;
        } else {
            var isSegue = false;
            let phoneNumber : String = self.phoneTextField.text!;
            if (phoneNumber.isEmpty) {
                SVProgressHUD.showInfo(withStatus: "请输入正确的手机号码");
                return isSegue;
            }
            
            let authText = self.authcodeTextField?.text!;
            if authText?.characters.count == 0 {
                SVProgressHUD.showInfo(withStatus: "请输入验证码");
                return isSegue;
            }
            
            if authText == self.authCode {
                SVProgressHUD.showInfo(withStatus: "验证码错误");
                return isSegue;
            }
            
            let textLength = self.passwordTextField.text?.characters.count;
            if textLength! < 6 || textLength! > 16 {
                self.passwordTextField.layer.borderColor = NavTitleColor.cgColor;
                var showString : String = "密码长度为6-16位";
                if textLength == 0 {
                    showString = "密码不能为空";
                }
                SVProgressHUD.showInfo(withStatus: showString);
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor;
                });
            } else if (self.passwordTextField.text != self.confirmTextField.text) {
                SVProgressHUD.showInfo(withStatus: "两次输入的密码不正确");
            } else {
                isSegue = true;
            }
            return isSegue;
        }
    }
}
