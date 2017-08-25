//
//  NTPrivacyViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/27.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTPrivacyViewController: NTBaseViewController {
    @IBOutlet weak var textView : UITextView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.textView?.isScrollEnabled = true;
    }

    override func popViewController() {
        self.dismiss(animated: true, completion: nil);
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
