//
//  NTFindViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/23.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTFindViewController: NTBaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemLine: UIView!
    @IBOutlet weak var topTabBar: UIStackView!
    var currentTag: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = nil;
        
        let textArray = [NSLocalizedString("RecommendTitle", comment: "RecommendTrends"),
                         NSLocalizedString("NearbyTitle", comment: "PeopleNearby")]
        var index = 0;
        for view in topTabBar.subviews {
            let btn = view as! UIButton
            btn.setTitle(textArray[index], for: .normal)
            index += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let offsetX = CGFloat(currentTag) * SCREENWIDTH
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
    
    @IBAction func navItemAction(_ sender: UIButton) {
        let stackView = sender.superview as! UIStackView
        for view in stackView.subviews {
            let btn = view as! UIButton
            if btn.isSelected {
                btn.isSelected = false
            }
        }
        sender.isSelected = true
        let tag = sender.tag
        currentTag = tag
        let offsetX = CGFloat(tag) * SCREENWIDTH
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
        let textW = sender.titleLabel?.bounds.size.width
        UIView.animate(withDuration: 0.25) {
            self.itemLine.bounds = CGRect.init(x: 0, y: 0, width: textW!, height: self.itemLine.bounds.size.height)
            self.itemLine.center.x = sender.center.x;
        };
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
