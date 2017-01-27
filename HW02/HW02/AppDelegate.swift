//
//  AppDelegate.swift
//  HW02
//
//  Created by Akash Ungarala on 7/24/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import Jukebox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    static var audioPlayer:Jukebox = Jukebox()
    static var playList = [Story]()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    func applicationWillResignActive(application: UIApplication) {}
    func applicationDidEnterBackground(application: UIApplication) {}
    func applicationWillEnterForeground(application: UIApplication) {}
    func applicationDidBecomeActive(application: UIApplication) {}
    func applicationWillTerminate(application: UIApplication) {}
}