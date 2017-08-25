//
//  NTLoginViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/23.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTLoginViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.phoneTextField.layer.borderWidth = 1;
        self.phoneTextField.layer.cornerRadius = 5;
        self.phoneTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.passwordTextField.layer.borderWidth = 1;
        self.passwordTextField.layer.cornerRadius = 5;
        self.passwordTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        NotificationCenter.default.addObserver(self,
                                               selector: NSSelectorFromString("closeViewController"),
                                               name: NSNotification.Name(rawValue: kNotificationLoginSuccess),
                                               object: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeViewController() -> Void {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func dismissLoginUI() {
        closeViewController();
    }

    @IBAction func loginAction() {
        let param = ["phone":"13276665576","password":"123123"];
        NTLoginTool.login(param: param, show: true);
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = NavTabBarColor.cgColor;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = ViewBorderColor.cgColor;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
