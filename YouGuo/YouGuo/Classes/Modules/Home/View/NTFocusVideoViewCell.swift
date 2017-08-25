//
//  NTFocusVideoViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/8/9.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import AlamofireImage

class NTFocusVideoViewCell: UITableViewCell {
    @IBOutlet weak fileprivate var header: UIImageView!
    @IBOutlet weak fileprivate var crown: UIImageView!
    @IBOutlet weak fileprivate var cert: UIImageView!
    @IBOutlet weak fileprivate var sex: UIImageView!
    @IBOutlet weak fileprivate var vip: UIImageView!
    @IBOutlet weak fileprivate var level: UIImageView!
    @IBOutlet weak fileprivate var tyrant: UIImageView!
    @IBOutlet weak fileprivate var time: UILabel!
    @IBOutlet weak fileprivate var name: UILabel!
    @IBOutlet weak fileprivate var title: UILabel!
    @IBOutlet weak fileprivate var cover: UIImageView!
    @IBOutlet weak fileprivate var praise: UIButton!
    @IBOutlet weak fileprivate var comment: UIButton!
    @IBOutlet weak fileprivate var playTimes: UIButton!
    @IBOutlet weak fileprivate var moreAction: UIButton!
    @IBOutlet weak fileprivate var vipWidth: NSLayoutConstraint!
    
    var model: NTHomeFocusModel {
        didSet {
            let headUrl = URL.init(string: model.headImg)
            header.af_setImage(withURL: headUrl!,
                               placeholderImage: UIImage.init(named: "my_head_default"),
                               filter: CircleFilter.init(),
                               progress: nil,
                               progressQueue: .global(),
                               imageTransition: .noTransition,
                               runImageTransitionIfCached: false,
                               completion: nil)
            
            if model.audit == 1 || model.audit == 3 {
                cert.isHidden = false
                cert.image = UIImage.init(named: model.audit == 1 ? "HeadLogo_Cert_P" : "HeadLogo_Cert_T")
            } else {
                cert.isHidden = true
            }
            sex.image = UIImage.init(named: model.sex == "男" ? "HeadLogo_Sex_B" : "HeadLogo_Sex_G")
            
            if model.isRecommend {
                vip.image = UIImage.init(named: "HeadLogo_VIP")
                vipWidth.constant = 29
            } else {
                vip.image =  nil
                vipWidth.constant = 0
            }

            if model.star > 0 {
                level.isHidden = false
                level.image = UIImage.init(named: "Level \(model.star)")
                tyrant.isHidden = model.star != 5
                crown.isHidden = model.star != 6
            } else {
                level.isHidden = true
            }
            
            name.text = model.nickName
            title.text = model.instro
            time.text = Date.timeSpacing(timeInterval: model.createTime)
            
            cover.af_setImage(withURL: URL.init(string: model.videoEvelope)!)
            
            praise.isSelected = model.isMyZan
            praise.setTitle("\(model.recommendCount)", for: .normal)
            comment.setTitle("\(model.commentCount)", for: .normal)
            playTimes.setTitle("\(model.playTimes)", for: .normal)
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

    required init?(coder aDecoder: NSCoder) {
        model = NTHomeFocusModel.init()
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }
}
