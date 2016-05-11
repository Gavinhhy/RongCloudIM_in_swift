//
//  AppDelegate.swift
//  IMTest
//
//  Created by Gavin on 16/5/5.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,  RCIMUserInfoDataSource,RCIMGroupInfoDataSource {

    var window: UIWindow?
    
    //设置appkey
    let rongcloudIMAppkey = "pwe86ga5em0g6"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //初始化融云sdk，在使用sdk的所有功能和显示相关view（包括继承与sdk的view）之前必须先初始化
        RCIM.sharedRCIM().initWithAppKey(rongcloudIMAppkey)
        
        //设置监听链接状态
        //RCIM.sharedRCIM().connectionStatusDelegate = self
 
        //设置消息接收的监听
       // RCIM.sharedRCIM().receiveMessageDelegate = self
        
        //设置用户信息提供者的代理为当前,否则无法显示用户头像，用户名，和本地通知
        RCIM.sharedRCIM().userInfoDataSource = self
        
        //设置群组信息提供者，需要提供正确的群组信息，否则无法显示群组头像，群名称和本地通知
        //RCIM.sharedRCIM().groupInfoDataSource = self
        
        //推送处理1
        if #available(iOS 8.0, *) {
            //注册推送,用于iOS8以上系统
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(forTypes:[.Alert, .Badge, .Sound], categories: nil))
        } else {
            //注册推送,用于iOS8以下系统
            application.registerForRemoteNotificationTypes([.Badge, .Alert, .Sound])
        }
        
        //点击远程推送的launchOptions内容格式请参考官网文档
        //http://www.rongcloud.cn/docs/ios.html#App_接收的消息推送格式
        
        //        token测试连接
        RCIM.sharedRCIM().connectWithToken("zOkJTXqHh1V9pwpecAN//gjdeGBRRgM4qWXn/myw2tvSgujmDYjDXy8QTmsHZ4ZgrGZSG7eZlJQXuH6WO0BUrw==", success: { (userId) -> Void in
            print("登陆成功。当前登录的用户ID：\(userId)")
            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                completion()
//            })
            
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
 
        
       
        
        
        return true
    }
    //推送处理2
    @available(iOS 8.0, *)
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        //注册推送,用于iOS8以上系统
        application.registerForRemoteNotifications()
    }
    
    //推送处理3
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var rcDevicetoken = deviceToken.description
        rcDevicetoken = rcDevicetoken.stringByReplacingOccurrencesOfString("<", withString: "")
        rcDevicetoken = rcDevicetoken.stringByReplacingOccurrencesOfString(">", withString: "")
        rcDevicetoken = rcDevicetoken.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        RCIMClient.sharedRCIMClient().setDeviceToken(rcDevicetoken)
    }
    
    //推送处理4
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //远程推送的userInfo内容格式请参考官网文档
        //http://www.rongcloud.cn/docs/ios.html#App_接收的消息推送格式
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        //本地通知
    }
    
    //监听连接状态变化
    func onRCIMConnectionStatusChanged(status: RCConnectionStatus) {
        print("RCConnectionStatus = \(status.rawValue)")
    }
    
    //用户信息提供者。您需要在completion中返回userId对应的用户信息，SDK将根据您提供的信息显示头像和用户名
        func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
            
            print("用户信息提供者，getUserInfoWithUserId:\(userId)")
            
            //简单的示例，根据userId获取对应的用户信息并返回
            //建议您在本地做一个缓存，只有缓存没有该用户信息的情况下，才去您的服务器获取，以提高用户体验
            //这里没有app serve ，使用硬编码
            switch userId {
            case "gavin":
                //如果您提供的头像地址是http连接，在iOS9以上的系统中，请设置使用http，否则无法正常显示
                //具体可以参考Info.plist中"App Transport Security Settings->Allow Arbitrary Loads"
                completion(RCUserInfo(userId: userId, name: "海洋", portrait: "http://pic4.zhimg.com/fc12553f8c97ad37e2a2613c8e9efcd3.jpg"))
            case "galler":
                completion(RCUserInfo(userId: userId, name: "佳乐", portrait: "http://pic3.zhimg.com/af55bad9819d7f8248cf55f54d31021e.jpg"))
            case "vivian":
                completion(RCUserInfo(userId: userId, name: "薇薇安", portrait: "http://pic4.zhimg.com/d6d6c8edaa6fd24c0df822e283faa963.jpg"))
            default:
                completion(RCUserInfo(userId: userId, name: "unknown", portrait: "http://www.rongcloud.cn/images/newVersion/logo/douguo.png"))
            }
        }
    func getGroupInfoWithGroupId(groupId: String!, completion: ((RCGroup!) -> Void)!) {
        switch groupId {
        case "group1":
            completion(RCGroup(groupId: groupId, groupName: "一起来嗨皮啊", portraitUri: "http://pic4.zhimg.com/9b9ef300c8879e13aa5a86443d867e47.jpg"))
        default:
            completion(RCGroup(groupId: groupId, groupName: "unknown", portraitUri: "http://www.rongcloud.cn/images/newVersion/logo/douguo.png"))
        }
    }
    
    //监听消息接收
    func onRCIMReceiveMessage(message: RCMessage!, left: Int32) {
        if (left != 0) {
            print("收到一条消息，当前的接收队列中还剩余\(left)条消息未接收，您可以等待left为0时再刷新UI以提高性能")
        } else {
            print("收到一条消息")
        }
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

