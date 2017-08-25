//
//  NTLocationViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/7/30.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTLocationViewCell: UITableViewCell {
    var selectedCityBlock: (_ cityName : String) -> Void = {_ in }
    var cityArray : Array<String> = [String]() {
        didSet {
            self.backgroundColor = BackgroundColor;
            
            let count = cityArray.count;
            let row = count % 3 == 0 ? (count / 3) : (count / 3 + 1);
            let col = 3;
            let marginX = 20;
            let marginY = 12;
            let btnW = (SCREENWIDTH - CGFloat(marginX * (col + 1))) / CGFloat(col);
            let btnH : CGFloat = 30.0;
            
            for i in 0..<row {
                let btnY = btnH * CGFloat(i) + CGFloat(marginY * (i + 1));
                for j in 0..<col {
                    let btnX = btnW * CGFloat(j) + CGFloat(marginX * (j + 1));
                    let index = i * col + j;
                    if index < count {
                        let btn = UIButton.init(type: .custom);
                        btn.frame = CGRect.init(x: btnX, y: btnY, width: btnW, height: btnH);
                        btn.layer.cornerRadius = 4;
                        btn.titleLabel?.font = UIFont.init(name: "STHeiti", size: 14);
                        btn.setTitle(cityArray[index], for: .normal);
                        btn.setTitleColor(DarkFontColor, for: .normal);
                        btn.backgroundColor = UIColor.white;
                        btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside);
                        self.addSubview(btn);
                    }
                }
            }
        }
    }
    
    func buttonClicked(button : UIButton) {
        let text : String = (button.titleLabel?.text)!;
        
        self.selectedCityBlock(text);
        
        if (text == "重新定位") {
            button.setTitle("正在定位", for: .normal);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
