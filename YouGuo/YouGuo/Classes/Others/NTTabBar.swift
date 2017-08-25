//
//  NTTabBar.swift
//  YouGuo
//
//  Created by YM on 2017/7/23.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

//格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
typealias swiftRetrunBlock = () -> Void

class NTTabBar: UITabBar {
//    private var plusBtn :UIButton;
    //var callBack = swiftRetrunBlock();

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame);
        let image:UIImage = UIImage.init(named: "tabbar_publish_s")!;
        let plusBtn:UIButton = UIButton.init(type: .custom);
        plusBtn.setBackgroundImage(image, for: UIControlState.normal);
        plusBtn.adjustsImageWhenDisabled = false;
        plusBtn.adjustsImageWhenHighlighted = false;
        plusBtn.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        plusBtn.bounds = CGRect.init(origin: CGPoint.init(), size: image.size);
        plusBtn.addTarget(self, action: #selector(NTTabBar.plusBtnAction), for: UIControlEvents.touchUpInside);
        self.addSubview(plusBtn);
        
        self.backgroundImage = UIImage();
        self.shadowImage = UIImage();
        self.tintColor = NavTabBarColor;
        self.backgroundColor = NavBackgroundColor;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews();
        
        let itemW:CGFloat = self.frame.size.width / 5;
        var index:Int = 0;
        for child in self.subviews {
            //设置宽度
            if child.isKind(of: NSClassFromString("UITabBarButton")!) {
                var frame: CGRect = child.frame;
                let itemX:CGFloat = CGFloat(index) * itemW;
                frame.origin.x = itemX;
                frame.size.width = itemW;
                child.frame = frame;
            
                index += 1;
                if index == 2 {
                    index += 1;
                }
            } else if child.isKind(of: NSClassFromString("UIButton")!) {
                let btn:UIButton = child as! UIButton;
                let image:UIImage = btn.currentBackgroundImage!;
                let size:CGSize = (image.size);
                let width:CGFloat = (size.width);
                let plusBtnX = (self.frame.size.width - width) * 0.5;
                let point = CGPoint.init(x: plusBtnX, y: -20);
                child.frame = CGRect.init(origin: point, size: size);
            }
        }
    }
    
    func plusBtnAction() {
        
    }
}
