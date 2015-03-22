//
//  AppDelegate.swift
//  make10_2
//
//  Created by 仙石晃久 on 3/15/15.
//  Copyright (c) 2015 AkihsiaSengoku. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gameMode = 0

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let scoreItems1 = defaults.objectForKey("g1Scores") as? [Double]{
            println("初期データありg1")
            println(scoreItems1)
        }else{
            var scoreItems : [Double] = []
            println("初期データなしー＞初期データ書き込み")
            for i in 0...8 {
                var num : Double = 0.00
                scoreItems.append(num)
            }
            //データの書き込み
            defaults.setObject(scoreItems, forKey: "g1Scores")
            defaults.synchronize()
        }
        
        if let scoreItems2 = defaults.objectForKey("g2Scores") as? [Int]{
            println("初期データありg2")
            println(scoreItems2)
        }else{
            var scoreItems : [Int] = []
            println("初期データ2なしー＞初期データ2書き込み")
            for i in 0...8 {
                var num : Int = 0
                scoreItems.append(num)
            }
            //データの書き込み
            defaults.setObject(scoreItems, forKey: "g2Scores")
            defaults.synchronize()
        }
        
        
        return true
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

