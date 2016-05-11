//
//  ContactViewController.swift
//  IMTest
//
//  Created by Gavin on 16/5/10.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import Haneke

class ContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tableData = [
        ["userId":"gavin","name":"海洋","avatar":"http://pic4.zhimg.com/fc12553f8c97ad37e2a2613c8e9efcd3.jpg"],
        ["userId":"galler","name":"佳乐","avatar":"http://pic3.zhimg.com/af55bad9819d7f8248cf55f54d31021e.jpg"],
        ["userId":"vivian","name":"薇薇安","avatar":"http://pic4.zhimg.com/d6d6c8edaa6fd24c0df822e283faa963.jpg"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //创建一个重用的单元格
        self.tableView.registerNib(UINib(nibName: "ContactTableViewCell",bundle: nil), forCellReuseIdentifier: "contactCell")

        // Do any additional setup after loading the view.
    }
    
    //创建一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //返回的列表行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
   //每行的高度
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 75
//    }
    
    //创建每行
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        let cell:ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier("contactCell") as! ContactTableViewCell
        let item = self.tableData[indexPath.row]
        
        cell.name.text = item["name"]
        let avatarUrl = item["avatar"]
        let url = NSURL(string: avatarUrl!)
        cell.avatar.hnk_setImageFromURL(url!)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //打开会话界面
        let item = self.tableData[indexPath.row]
        let chatWithSelf = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: item["userId"])
        chatWithSelf.title = item["name"]
        self.navigationController?.pushViewController(chatWithSelf, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
