//
//  AppDelegate.swift
//  MacCalendar
//
//  Created by bugcode on 16/7/16.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var calViewController:CalendarViewController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let calController = CalendarViewController()
        calController.showWindow(self)
        self.calViewController = calController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

