//
//  NTRootTabBarViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/22.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTRootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var tabIndex = 0;
        let titleArray = [NSLocalizedString("HomeTitle", comment: "Home"),
                          NSLocalizedString("FindTitle", comment: "Find"),
                          NSLocalizedString("NewsTitle", comment: "News"),
                          NSLocalizedString("MineTitle", comment: "Mine")];
        let imageArray = [["normalImage":"tabbar_home_n","selectImage":"tabbar_home_s"],
                          ["normalImage":"tabbar_disc_n","selectImage":"tabbar_disc_s"],
                          ["normalImage":"tabbar_mesg_n","selectImage":"tabbar_mesg_s"],
                          ["normalImage":"tabbar_prof_n","selectImage":"tabbar_prof_s"]];
        for subVC:UIViewController in self.childViewControllers {
            subVC.title = titleArray[tabIndex];
            let textAttrs:NSMutableDictionary = NSMutableDictionary();
            textAttrs.setValue(LightFontColor, forKey: NSForegroundColorAttributeName);
            let selectAttrs:NSMutableDictionary = NSMutableDictionary();
            selectAttrs.setValue(NavTabBarColor, forKey: NSForegroundColorAttributeName);
            subVC.tabBarItem.setTitleTextAttributes(textAttrs as? [String : Any], for: UIControlState.normal)
            subVC.tabBarItem.setTitleTextAttributes(selectAttrs as? [String : Any], for: UIControlState.selected);
            subVC.tabBarItem.image = UIImage.init(named: imageArray[tabIndex]["normalImage"]!);
            subVC.tabBarItem.selectedImage = UIImage.init(named: imageArray[tabIndex]["selectImage"]!);
            subVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -6);
            tabIndex += 1;
        }
        
        let tabBar:NTTabBar = NTTabBar.init(frame: self.tabBar.frame);
        self.setValue(tabBar, forKey: "tabBar");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
