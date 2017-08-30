//
//  HomepageViewController.swift
//  IOSGdims
//
//  Created by 包宏燕 on 2017/8/30.
//  Copyright © 2017年 name. All rights reserved.
//

import UIKit

var cells: [CellModel] = []

class HomepageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //行数
    var cellsNum = 1
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "todoCell")!
        return cell
    }

}
