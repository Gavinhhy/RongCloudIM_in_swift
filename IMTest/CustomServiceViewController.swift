//
//  CustomServiceViewController.swift
//  IMTest
//
//  Created by Gavin on 16/5/11.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class CustomServiceViewController: UIViewController {

    @IBAction func chatService(sender: UIButton) {
        let chatService = RCDCustomServiceViewController()
        //chatService.userName = "客服一号"
        chatService.conversationType = RCConversationType.ConversationType_CUSTOMERSERVICE
        chatService.targetId = "KEFU146289095231582"
        chatService.title = "正在和客服会话"
        self.navigationController?.pushViewController(chatService, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
