//
//  HomepageViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/8/30.
//  Copyright © 2017年 name. All rights reserved.
//  根据人员类型加载不同的主页数据

import UIKit

class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var titleBar: UINavigationBar!
    @IBOutlet weak var titleContent: UIBarButtonItem!
    
    var cells: [CellModel] = []
    //行数
    var cellsNum = 1
    var typeNum = ""
    var userDefault = UserDefaultUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeNum = userDefault.getUser(forKey: "typeNumber") as String!
        
        //群测群防
        if "0" == typeNum {
            cells = [CellModel(id: "1", image: "monitor", title: "灾害点监测")]
            titleContent.title = "│群测群防"
            cellsNum = 1
        }
        //驻守人员
        else if "1" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "日志上报"), CellModel(id: "2", image: "disaster", title: "灾情速报")]
            titleContent.title = "│驻守人员"
            cellsNum = 2
        }
        //片区专管
        else if "2" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "片区周报")]
            titleContent.title = "│片区专管"
            cellsNum = 1
        }
        //村级巡查
        else if "3" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "村级周报"), CellModel(id: "2", image: "disaster", title: "灾情速报")]
            titleContent.title = "│村级巡查"
            cellsNum = 2
        }
        
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     返回TableView的行数
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsNum
    }
    
    /*
     自定义每行要显示的效果
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "todoCell")!
        
        let cm = cells[indexPath.row] as CellModel
        let image = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        image.image = UIImage(named: cm.image)
        title.text = cm.title
        
        //设置
        myTableView.autoAddLineToCell(cell, indexPath: indexPath, lineColor: UIColor.lightGray)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if "1" == typeNum && "1" == cells[indexPath.row].id {
            //跳转页面
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "DailyReportViewController") as! DailyReportViewController
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
    }

    /*释放当前页面*/
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
}

extension UITableView {
    private var FLAG_TABLE_VIEW_CELL_LINE: Int {
        get { return 977322 }
    }
    
    //自动添加线条
    func autoAddLineToCell(_ cell: UITableViewCell, indexPath: IndexPath, lineColor: UIColor) {
        let lineView = cell.viewWithTag(FLAG_TABLE_VIEW_CELL_LINE)
        if self.isNeedShow(indexPath) {
            if lineView == nil {
                self.addLineToCell(cell, lineColor: lineColor)
            }
        } else {
            lineView?.removeFromSuperview()
        }
    }
    
    private func addLineToCell(_ cell: UITableViewCell, lineColor: UIColor){
        let view = UIView(frame: CGRect(x: 0, y: 99, width: self.bounds.width, height: 0.5))
        view.tag = FLAG_TABLE_VIEW_CELL_LINE
        view.backgroundColor = lineColor
        cell.contentView.addSubview(view)
    }
    
    private func isNeedShow(_ indexPath: IndexPath) -> Bool {
        let countCell = self.countCell(indexPath.section)
        if 0 == countCell {
            return false
        }
        return true
    }
    
    private func countCell(_ atSection: Int) -> Int {
        return self.numberOfRows(inSection: atSection)
    }
}
