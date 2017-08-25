//
//  NTHotViewController.swift
//  YouGuo
//
//  Created by YM on 2017/8/7.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import PullToRefreshKit
import SVProgressHUD
import HandyJSON

class NTHotViewController: NTBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var pageNo = 1
    fileprivate let pageSize = 10
    
    /// 懒加载 模型数组
    lazy var modelArray: [NTHomeHotModel] = { () -> [NTHomeHotModel] in
        var array = [NTHomeHotModel]();
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let itemW = (SCREENWIDTH - 19) * 0.5
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: itemW, height: itemW)
        
        //
        _ = self.collectionView.setUpHeaderRefresh {
            [weak self] in
            self?.loadNewData()
        }
        
        _ = self.collectionView.setUpFooterRefresh {
            [weak self] in
            self?.loadMoreData()
        }
        
        self.loadNewData()
    }
    
    func loadNewData() {
        self.pageNo = 1;
        self.loadingDataFromServer();
    }
    
    func loadMoreData() {
        self.pageNo += 1;
        self.loadingDataFromServer();
    }
    
    func loadingDataFromServer() {
        _ = NTNetworkTool.getHomeHotData(pageNo: self.pageNo, pageSize: self.pageSize, success: { [weak self](response) in
            let list = response["list"] as! [Dictionary<String, Any>]
            //print("response = \(response) \n array = \(array)")
            self?.loadSuccess(responseData: list)
        }) { [weak self](error) in
            self?.loadFailure(error: error)
        }
    }
    
    func loadSuccess(responseData: [Dictionary<String, Any>]) {
        let data : Data = try! JSONSerialization.data(withJSONObject: responseData, options: [])
        let JSONString = String.init(bytes: data, encoding: .utf8)
        let muArray = JSONDeserializer<NTHomeHotModel>.deserializeModelArrayFrom(json: JSONString) as! Array<NTHomeHotModel>
        
        if muArray.count < self.pageSize {
            self.collectionView.endFooterRefreshingWithNoMoreData()
        } else {
            self.collectionView.endFooterRefreshing()
        }
//        print("muArray = \(muArray)")
        if self.pageNo == 1 {
            self.collectionView.endHeaderRefreshing()
            self.modelArray = muArray;
            self.collectionView.reloadData();
        } else {
            self.modelArray.append(contentsOf: muArray)
            self.collectionView.reloadData();
        }
    }
    
    func loadFailure(error: Error) {
        if self.pageNo == 1 {
            self.collectionView.endHeaderRefreshing()
        } else {
            self.collectionView.endFooterRefreshing()
        }
        SVProgressHUD.showError(withStatus: "\(error.localizedDescription)")
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

extension NTHotViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension NTHotViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NTHotViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NTHotViewCell", for: indexPath) as! NTHotViewCell
        cell.model = self.modelArray[indexPath.row]
        return cell
    }
}
