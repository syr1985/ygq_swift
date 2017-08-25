//
//  NTVideoViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/8/8.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import AlamofireImage

class NTVideoViewCell: UICollectionViewCell {
    @IBOutlet weak var videoCover: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sex: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var playTimes: UIButton!
    
    var model: NTHomeVideoModel {
        didSet {
            if model.videoEvelope.characters.count != 0 {
                videoCover.af_setImage(withURL: URL.init(string: model.videoEvelope)!)
            }
            let sexImageName = model.sex == "男" ? "HeadLogo_Sex_B" : "HeadLogo_Sex_G"
            sex.image = UIImage.init(named: sexImageName)
            city.text = model.city
            name.text = model.nickName
            playTimes.setTitle(String(describing: model.duration), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        model = NTHomeVideoModel.init()
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }

}
