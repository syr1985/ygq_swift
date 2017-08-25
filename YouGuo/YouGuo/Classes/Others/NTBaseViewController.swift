//
//  NTBaseViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/23.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = BackgroundColor;
        self.navigationController?.navigationBar.tintColor = DarkFontColor;
        self.navigationController?.navigationBar.barTintColor = NavBackgroundColor;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:DarkFontColor,
                                                                        NSFontAttributeName:NavTitleFont];
        
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: "Arrow_Left"),
                                            style: UIBarButtonItemStyle.plain,
                                            target: self,
                                            action: NSSelectorFromString("popViewController"));
        leftItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.hidesBackButton = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && (self.view.window != nil)) {// 是否是正在使用的视图
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
//        if (![LoginData sharedLoginData].userId) {
//            popViewController();
//        }
    }
    
    func popViewController() -> Void {
        self.navigationController?.popViewController(animated: true);
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
