//
//  HomepageViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/8/30.
//  Copyright © 2017年 name. All rights reserved.
//

import UIKit



class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
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
            cellsNum = 1
        }
        //驻守人员
        else if "1" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "日志上报"), CellModel(id: "2", image: "disaster", title: "灾情速报")]
            cellsNum = 2
        }
        //片区专管
        else if "2" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "片区周报")]
            cellsNum = 1
        }
        //村级巡查
        else if "3" == typeNum {
            cells = [CellModel(id: "1", image: "daily", title: "村级周报"), CellModel(id: "2", image: "disaster", title: "灾情速报")]
            cellsNum = 2
        }
        
        myTableView.dataSource = self
        
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
        
        return cell
    }

}
