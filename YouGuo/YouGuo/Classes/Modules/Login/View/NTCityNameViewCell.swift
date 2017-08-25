//
//  NTCityNameViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/7/30.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTCityNameViewCell: UITableViewCell {
    @IBOutlet weak private var cityNameLabel: UILabel!
    var cityName : String = "" {
        didSet {
            cityNameLabel.text = cityName;
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
