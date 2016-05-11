//
//  ConversationViewController.swift
//  IMTest
//
//  Created by Gavin on 16/5/5.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.conversationType = RCConversationType.ConversationType_PRIVATE
//        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
//        self.targetId = "gavin"
//        //设置聊天会话界面要显示的标题
//        self.title = "海洋"
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
