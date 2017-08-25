//
//  NTChooseCityViewController.swift
//  YouGuo
//
//  Created by YM on 2017/7/30.
//  Copyright © 2017年 NewTouch. All rights reserved.
//

import UIKit

class NTCityListForChooseViewController: NTBaseViewController  {
    @IBOutlet weak var tableView : UITableView?;
    @IBOutlet weak var searchBackView: UIView!
    var selectCityCallBack: (_ cityName: String) -> Void = {_ in }
    
    deinit {
        print("\(self)")
    }
    /// 懒加载 城市数据
    lazy var cityDictionary: [String: [String]] = { () -> [String : [String]] in
        let fileManager = FileManager.default;
        let urlForDocument = fileManager.urls(for: .documentDirectory, in:.userDomainMask);
        let url = urlForDocument[0] as URL;
        let docPath : URL = url.appendingPathComponent("YGQ_CITIES.plist");
        
        if !fileManager.fileExists(atPath: docPath.relativePath) {
            let path = Bundle.main.path(forResource: "cities", ofType: "plist")!;
            if let retureMessage = try? fileManager.copyItem(atPath: path, toPath: docPath.relativePath) {
                print("\(retureMessage)");
            }
        }
        
        let dic = NSDictionary(contentsOfFile: docPath.relativePath) as? [String: [String]];
        return dic ?? [:]
    }()
    
    /// 懒加载 标题数组
    lazy var titlesArray: [String] = { () -> [String] in
        var array = [String]();
        for str in self.cityDictionary.keys {
            array.append(str);
        }
        // 标题排序
        array.sort()
        array.removeLast();
        array.removeLast();
        array.removeLast();
        array.insert("热门", at: 0);
        array.insert("最近", at: 0);
        array.insert("定位", at: 0);
        
        return array
    }()
    
    /// 搜索控制器
    lazy var searchVC: UISearchController = {
        let searchVc = UISearchController(searchResultsController: self.searchResultVC)
        searchVc.delegate = self as UISearchControllerDelegate
        searchVc.searchResultsUpdater = self
        searchVc.hidesNavigationBarDuringPresentation = false
        searchVc.definesPresentationContext = true
        searchVc.searchBar.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 44)
        searchVc.searchBar.placeholder = "输入城市名或拼音"
//        searchVc.searchBar.backgroundImage = UIImage.init(named: "SearchBackground")
        searchVc.searchBar.delegate = self as UISearchBarDelegate
        
        return searchVc
    }()
    /// 搜索结果控制器
    lazy var searchResultVC: NTSearchCityResultViewController = NTSearchCityResultViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchBackView.addSubview(self.searchVC.searchBar);
        
        self.tableView?.backgroundColor = BackgroundColor;
        self.tableView?.register(NTLocationViewCell.classForCoder(), forCellReuseIdentifier: "NTLocationViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: tableView 数据源方法
extension NTCityListForChooseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titlesArray.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 3 {
            return 1;
        } else {
            let cityName = self.titlesArray[section];
            let cityArray = self.cityDictionary[cityName];
            return cityArray!.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell : NTLocationViewCell = tableView.dequeueReusableCell(withIdentifier: "NTLocationViewCell", for: indexPath) as! NTLocationViewCell;
            
            unowned let weakself = self;
            cell.selectedCityBlock = {(cityName : String) in
                weakself.selectCityCallBack(cityName);
                weakself.navigationController?.popViewController(animated: true);
            }
            
            let titleName = self.titlesArray[indexPath.section];
            cell.cityArray = self.cityDictionary[titleName]!;
            
            return cell;
        } else {
            let cell : NTCityNameViewCell = tableView.dequeueReusableCell(withIdentifier: "NTCityNameViewCell", for: indexPath) as! NTCityNameViewCell;
            
            let titleName = self.titlesArray[indexPath.section];
            let cityArray = (self.cityDictionary[titleName]! as NSArray);
            cell.cityName = cityArray[indexPath.row] as! String;
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 23))
        headerView.backgroundColor = ViewBorderColor;
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: SCREENWIDTH-20, height: 23));
        label.font = UIFont.init(name: "STHeiti", size: 12);
        label.textColor = UIColor.init(red: 132 / 255.0, green: 132 / 255.0, blue: 132 / 255.0, alpha: 1);
        label.text = self.titlesArray[section];
//        if section == 0 {
//            label.text = "定位城市";
//        } else if (section == 1) {
//            label.text = "最近访问城市";
//        } else if (section == 2) {
//            label.text = "热门城市";
//        } else {
//            
//        }
        headerView.addSubview(label);
        
        return headerView;
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.titlesArray;
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return self.titlesArray.index(of:title)!;
    }
}

// MARK: tableView 代理方法
extension NTCityListForChooseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 2 {
            let key: String = self.titlesArray[indexPath.section];
            let cityArray: Array = self.cityDictionary[key]!;
            let cityName: String = cityArray[indexPath.row];
            self.selectCityCallBack(cityName);
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 3 {
            let cityName = self.titlesArray[indexPath.section];
            let cityArray = self.cityDictionary[cityName];
            let rows = cityArray!.count % 3 == 0 ? cityArray!.count / 3 : cityArray!.count / 3 + 1;
            return CGFloat(rows * 30 + (rows + 1) * 12);
        } else {
            return 56;
        }
    }
}

// MARK: UISearchResultsUpdating
extension NTCityListForChooseViewController: UISearchResultsUpdating, UISearchControllerDelegate  {
    //pragma mark - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchResultArray(searchBarText: searchBar.text!)
    }

    func updateSearchResults(for searchController: UISearchController) {
        getSearchResultArray(searchBarText: searchController.searchBar.text ?? "")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
    // 隐藏取消按钮
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
}

// MARK: searchBar 代理方法
extension NTCityListForChooseViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

extension NTCityListForChooseViewController {
    fileprivate func getSearchResultArray(searchBarText: String) {
        var resultArray:[String] = []
        if searchBarText == "" {
            searchResultVC.resultArray = resultArray
            searchResultVC.tableView.reloadData()
            return
        }
        // 传递闭包 当点击’搜索结果‘的cell调用
        searchResultVC.callBack = { [weak self](cityName : String) in
            // 搜索完成 关闭resultVC
            self?.searchVC.isActive = false
            self?.selectCityCallBack(cityName);
            self?.navigationController?.popViewController(animated: true);
        }
        // 中文搜索
        if searchBarText.isIncludeChineseIn() {
            // 转拼音
            let pinyin = searchBarText.chineseToPinyin()
            // 获取大写首字母
            let first = String(pinyin[pinyin.startIndex]).uppercased()
            guard let dic = cityDictionary[first] else {
                return
            }
            for str in dic {
                if str.hasPrefix(searchBarText) {
                    resultArray.append(str)
                }
            }
            searchResultVC.resultArray = resultArray
            searchResultVC.tableView.reloadData()
        } else {
            // 拼音搜索
            // 若字符个数为1
            if searchBarText.characters.count == 1 {
                guard let dic = cityDictionary[searchBarText.uppercased()] else {
                    return
                }
                resultArray = dic
                searchResultVC.resultArray = resultArray
                searchResultVC.tableView.reloadData()
            } else {
                guard let dic = cityDictionary[searchBarText.first().uppercased()] else {
                    return
                }
                for str in dic {
                    // 去空格
                    let py = String(str.chineseToPinyin().characters.filter({ $0 != " "}))
                    let range = py.range(of: searchBarText)
                    if range != nil {
                        resultArray.append(str)
                    }
                }
                // 加入首字母判断 如 cq => 重庆 bj => 北京
                if resultArray.count == 0 {
                    for str in dic {
                        // 北京 => bei jing
                        let pinyin = str.chineseToPinyin()
                        // 获取空格的index
                        let a = pinyin.characters.index(of: " ")
                        let index = pinyin.index(a!, offsetBy: 2)
                        // offsetBy: 2 截取 bei j
                        // offsetBy: 1 截取 bei+空格
                        // substring(to: index) 不包含 index最后那个下标
                        let py = pinyin.substring(to: index)
                        /// 获取第二个首字母
                        ///
                        ///     py = "bei j"
                        ///     last = "j"
                        ///
                        let last = py.substring(from: py.index(py.endIndex, offsetBy: -1))
                        /// 两个首字母
                        let pyIndex = String(pinyin[pinyin.startIndex]) + last
                        
                        if searchBarText.lowercased() == pyIndex {
                            resultArray.append(str)
                        }
                    }
                }
                searchResultVC.resultArray = resultArray
                searchResultVC.tableView.reloadData()
            }
        }
    }
}

extension String {
    // MARK: 汉字 -> 拼音
    func chineseToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        return pinyin
    }
    
    // MARK: 判断是否含有中文
    func isIncludeChineseIn() -> Bool {
        for (_, value) in self.characters.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    // MARK: 获取第一个字符
    func first() -> String {
        let index = self.index(self.startIndex, offsetBy: 1)
        return self.substring(to: index)
    }
}

