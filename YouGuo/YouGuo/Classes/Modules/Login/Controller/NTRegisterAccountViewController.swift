//
//  NTRegisterAccountViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/26.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTRegisterAccountViewController: NTBaseViewController , UITextFieldDelegate {
    var telephone : String = "";
    var passsword : String = "";
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var selectCityTextField: UITextField!
    @IBOutlet weak var sexBackView: UIView!
    @IBOutlet weak var cityBackView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    private var sex  : String = "";
    private var city : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let padding = UIEdgeInsetsMake(5, 10, 5, 0);
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 36));
        let phoneLabel = UILabel.init();
        phoneLabel.text = NSLocalizedString("UserName", comment: "Name");
        phoneLabel.font = UIFont.init(name: "STHeiti", size: 14);
        phoneLabel.textColor = DarkFontColor;
        leftView.addSubview(phoneLabel);
        phoneLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(leftView).inset(padding);
        }
        self.userNameTextField.leftView = leftView;
        self.userNameTextField.leftViewMode = .always;
        self.userNameTextField.layer.borderWidth = 1;
        self.userNameTextField.layer.cornerRadius = 5;
        self.userNameTextField.layer.borderColor = ViewBorderColor.cgColor;
        
        self.sexBackView.layer.borderWidth = 1;
        self.sexBackView.layer.cornerRadius = 5;
        self.sexBackView.layer.borderColor = ViewBorderColor.cgColor;
        
        self.cityBackView.layer.borderWidth = 1;
        self.cityBackView.layer.cornerRadius = 5;
        self.cityBackView.layer.borderColor = ViewBorderColor.cgColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectSex(_ sender: UIButton) {
        if (sender.isSelected) {
            return;
        }
        
        sender.isSelected = true;
        self.sex = sender.tag == 1 ? NSLocalizedString("SexBoy", comment: "Boy") : NSLocalizedString("SexGirl", comment: "Girl");
        
        let contentView = sender.superview;
        let btn = contentView?.viewWithTag(sender.tag == 1 ? 2 : 1) as? UIButton;
        btn?.isSelected = false;
        
        let userName : String = self.userNameTextField.text!;
        let cityName : String = self.selectCityTextField.text!;
        if (userName.characters.count != 0 && cityName.characters.count != 0) {
            self.registerButton.isEnabled = true;
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        self.view .endEditing(true);
        
        // register
        let userName : String = self.userNameTextField.text!;
        NTLoginTool.register(param: ["phonenum" : self.telephone,
                                     "password" : self.passsword,
                                     "nickname" : userName,
                                     "usersex"  : self.sex,
                                     "usercity" : self.city])
    }
    
    @IBAction func selectCurrentCity() {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.sex.characters.count != 0 && self.city.characters.count != 0 {
            self.registerButton.isEnabled = true;
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as? NTCityListForChooseViewController;
        destVC?.selectCityCallBack = { [weak self](cityName : String) in
            self?.city = cityName;
            self?.selectCityTextField.text = cityName;
        }
    }
}
