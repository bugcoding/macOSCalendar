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
    let icon: IconView

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let calController = CalendarViewController()
        //calController.showWindow(self)
        self.calViewController = calController
    }
    // 窗口失去焦点的时候自动关闭
    func applicationDidResignActive(_ notification: Notification) {
        self.icon.isSelected = false
        self.calViewController?.window?.close()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func openWindow() {

        let eventFrame = NSApp.currentEvent?.window?.frame
        let eventOrigin = eventFrame?.origin
        let eventSize = eventFrame?.size
        
        let window = calViewController?.window
        let windowFrame = window?.frame
        let windowSize = windowFrame?.size
        
        // 设置状态栏窗口的位置
        let windowTopLeftPosition = CGPoint(x: (eventOrigin?.x)! + (eventSize?.width)! / 2.0 - (windowSize?.width)! / 2.0, y: (eventOrigin?.y)! - 2)
        window?.setFrameTopLeftPoint(windowTopLeftPosition)
    
        window?.makeKeyAndOrderFront(self)
        
        NSApp.activate(ignoringOtherApps: true)
    }
    override init()
    {
        let bar = NSStatusBar.system()
        
        let length = NSVariableStatusItemLength
        let item = bar.statusItem(withLength: length)
        
        self.icon = IconView(imageName: "icon", item: item)
        item.view = self.icon
        
        super.init()
    }
    
    override func awakeFromNib() {
        self.icon.onMouseDown = {
            if (self.icon.isSelected)
            {
                self.openWindow()
                return
            }
            self.calViewController?.window?.close()
        }
    }
}

