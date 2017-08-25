//
//  NTHotViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/8/7.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import AlamofireImage

class NTHotViewCell: UICollectionViewCell {
    @IBOutlet weak private var header: UIImageView!
    @IBOutlet weak private var sex: UIImageView!
    @IBOutlet weak private var city: UILabel!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var images: UIButton!

    var model: NTHomeHotModel {
        didSet {
            if model.headImg.characters.count != 0 {
                header.af_setImage(withURL: URL.init(string: model.headImg)!)
            }
            let sexImageName = model.sex == "男" ? "HeadLogo_Sex_B" : "HeadLogo_Sex_G"
            sex.image = UIImage.init(named: sexImageName)
            city.text = model.city
            name.text = model.nickName
            images.setTitle(String(describing: model.imageCount), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        model = NTHomeHotModel.init()
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }
}
