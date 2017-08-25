//
//  NTFocusTrendsViewCell.swift
//  YouGuo
//
//  Created by YM on 2017/8/9.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import AlamofireImage
import Kingfisher

class NTFocusTrendsViewCell: UITableViewCell {
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
    @IBOutlet weak fileprivate var back: UIView!
    @IBOutlet weak fileprivate var praise: UIButton!
    @IBOutlet weak fileprivate var comment: UIButton!
    @IBOutlet weak fileprivate var gift: UIButton!
    @IBOutlet weak fileprivate var moreAction: UIButton!
    @IBOutlet weak fileprivate var vipWidth: NSLayoutConstraint!
    
    var model: NTHomeFocusModel {
        didSet {
            let headUrl = URL.init(string: model.headImg)
            //header.af_setImage(withURL: headUrl!)
            //header.kf.setImage(with: headUrl)
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

            praise.isSelected = model.isMyZan
            praise.setTitle("\(model.recommendCount)", for: .normal)
            
            if model.feedsType == 1 {
                gift.isHidden = true
            } else {
                gift.isHidden = false
                gift.setTitle("\(model.buyCount)", for: .normal)
            }
            
            if model.imageUrl.characters.count != 0 {
                self.downloadImage()
            }
        }
    }
    
    private func downloadImage() {
        for view in back.subviews {
            view.removeFromSuperview()
        }
        
        let margin = 6
        let maxCol = 3
        var defaultW = (back.bounds.size.width - CGFloat((maxCol - 1) * margin)) / CGFloat(maxCol)
        
        if model.imageUrl.contains(";") {
            let urlArray = model.imageUrl.components(separatedBy: ";")
            let count = urlArray.count
            let col = (count == 4 ? 2 : (count > 2 ? maxCol : count))
            let row = (count % maxCol == 0 ? (count / maxCol) : (count / maxCol + 1))
            
            for i in 0..<row {
                let viewY = (defaultW + CGFloat(margin)) * CGFloat(i)
                for j in 0..<col {
                    let viewX = (defaultW + CGFloat(margin)) * CGFloat(j)
                    let index = i * col + j
                    if index < count {
                        let imageUrl = urlArray[index] 
                        self.createImageView(viewX: viewX,
                                             viewY: viewY,
                                             imageW: defaultW,
                                             imageH: defaultW,
                                             imageUrl: imageUrl,
                                             imageTag: index,
                                             single: false)
                    }
                }
            }
        } else {
            defaultW = 178
            self.createImageView(viewX: 0,
                                 viewY: 0,
                                 imageW: defaultW,
                                 imageH: defaultW,
                                 imageUrl: model.imageUrl,
                                 imageTag: 0,
                                 single: true)
        }
    }
    
    private func createImageView(viewX: CGFloat, viewY: CGFloat, imageW: CGFloat, imageH: CGFloat, imageUrl: String, imageTag: Int, single: Bool) {
        let imageView = UIImageView.init(frame: CGRect.init(x: viewX, y: viewY, width: imageW, height: imageH))
        imageView.tag = imageTag
        imageView.isUserInteractionEnabled = true
        back.addSubview(imageView)
        
        let imageEncodeUrlStr = String.cropImageUrlWithUrlString(imageUrl: imageUrl, width: imageW, height: imageH)
        let imageEncodeUrl = URL.init(string: imageEncodeUrlStr)
        
        if  !model.isBuy &&
            model.feedsType == 4 &&
            model.userId != NTLoginModel.sharedInstance.id {
            let radius = single ? 50 : UInt(imageW) / 4;
            imageView.af_setImage(withURL: imageEncodeUrl!,
                                  placeholderImage: nil,
                                  filter: BlurFilter.init(blurRadius: radius),
                                  progress: nil,
                                  progressQueue: .global(),
                                  imageTransition: .crossDissolve(1),
                                  runImageTransitionIfCached: true,
                                  completion: { (DataResponse) in
                print("\(String(describing: DataResponse.result.value))")
            })
        } else {
            imageView.af_setImage(withURL: imageEncodeUrl!)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapImageView))
        imageView.addGestureRecognizer(tap)
    }
    
    func tapImageView(tap: UITapGestureRecognizer) {
        print("tapImageView")
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


