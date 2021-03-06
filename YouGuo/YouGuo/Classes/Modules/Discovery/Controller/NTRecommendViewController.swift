//
//  NTRecommendViewController.swift
//  YouGuo
//
//  Created by YM on 2017/8/16.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit
import PullToRefreshKit
import SVProgressHUD
import HandyJSON

class NTRecommendViewController: NTBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var pageNo = 1
    fileprivate let pageSize = 10
    fileprivate let font = UIFont.init(name: "STHeiti", size: 14)
    fileprivate let size = CGSize.init(width: SCREENWIDTH - 24, height: 0)
    
    /// 懒加载 模型数组
    lazy var modelArray: [NTHomeFocusModel] = { () -> [NTHomeFocusModel] in
        var array = [NTHomeFocusModel]();
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //
        _ = self.tableView.setUpHeaderRefresh {
            [weak self] in
            self?.loadNewData()
        }
        
        _ = self.tableView.setUpFooterRefresh {
            [weak self] in
            self?.loadMoreData()
            }.SetUp({ (DefaultRefreshFooter) in
                DefaultRefreshFooter.refreshMode = .scroll
            })
        
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
        _ = NTNetworkTool.getHomeFocusData(pageNo: self.pageNo, pageSize: self.pageSize, success: { [weak self](response) in
            //print("response = \(response)")
            let list = response["list"] as! [Dictionary<String, Any>]
            self?.loadSuccess(responseData: list)
            }, failure: { [weak self](error) in
                self?.loadFailure(error: error)
        })
    }
    
    func loadSuccess(responseData: [Dictionary<String, Any>]) {
        let data : Data = try! JSONSerialization.data(withJSONObject: responseData, options: [])
        let JSONString = String.init(bytes: data, encoding: .utf8)
        let muArray = JSONDeserializer<NTHomeFocusModel>.deserializeModelArrayFrom(json: JSONString) as! Array<NTHomeFocusModel>
        
        if muArray.count < self.pageSize {
            self.tableView.endFooterRefreshingWithNoMoreData()
        } else {
            self.tableView.endFooterRefreshing()
        }
        //print("muArray = \(muArray)")
        if self.pageNo == 1 {
            self.tableView.endHeaderRefreshing(.success)
            self.modelArray = muArray;
            self.tableView.reloadData();
        } else {
            self.modelArray.append(contentsOf: muArray)
            self.tableView.reloadData();
        }
    }
    
    func loadFailure(error: Error) {
        if self.pageNo == 1 {
            self.tableView.endHeaderRefreshing(.failure)
        } else {
            self.tableView.endFooterRefreshing()
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

extension NTRecommendViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension NTRecommendViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        if model.feedsType == 1 || model.feedsType == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NTFocusTrendsViewCell", for: indexPath) as! NTFocusTrendsViewCell
            cell.model = model
            return cell
        } else if model.feedsType == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NTFocusVideoViewCell", for: indexPath) as! NTFocusVideoViewCell
            cell.model = model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NTFocusProductViewCell", for: indexPath) as! NTFocusProductViewCell
            cell.model = model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.modelArray[indexPath.row]
        return model.cellHeight()
    }
}

