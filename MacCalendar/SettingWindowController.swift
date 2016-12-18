//
//  SettingWindow.swift
//  StatebarCalendar
//
//  Created by bugcode on 2016/12/11.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class SettingWindowController : NSWindowController, NSWindowDelegate {
    
    static let HOLIDAY_COLOR_TAG = "holidayColor"
    static let FESTIVAL_COLOR_TAG = "festivalColor"
    
    @IBOutlet weak var startUpCheckBtn: NSButton!
    
    @IBOutlet weak var resetColorBtn: NSButton!
    
    @IBAction func resetColorSetting(_ sender: NSButton) {
        UserDefaults.standard.removeObject(forKey: SettingWindowController.HOLIDAY_COLOR_TAG)
        UserDefaults.standard.removeObject(forKey: SettingWindowController.FESTIVAL_COLOR_TAG)
        
        holidayColorWell.color = .red
        festivalColorWell.color = .black
        
        (NSApp.delegate as! AppDelegate).refreshInterface()
    }
    
    
    @IBOutlet weak var holidayColorWell: NSColorWell!
    @IBOutlet weak var festivalColorWell: NSColorWell!
    // 假日颜色
    @IBAction func holidaysWellPick(_ sender: NSColorWell) {
        let color = sender.color
        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        print("holidaysWellPick color = \(color)")
        UserDefaults.standard.setValue(data, forKey: SettingWindowController.HOLIDAY_COLOR_TAG)
        let delegate = NSApp.delegate as! AppDelegate
        delegate.refreshInterface()
    }
    // 节日颜色
    @IBAction func festivalWellPick(_ sender: NSColorWell) {
        let color = sender.color
        print("festivalWellPick color = \(color)")
        let data = NSKeyedArchiver.archivedData(withRootObject: color)

        UserDefaults.standard.setValue(data, forKey: SettingWindowController.FESTIVAL_COLOR_TAG)
        let delegate = NSApp.delegate as! AppDelegate
        delegate.refreshInterface()
    }

    func windowShouldClose(_ sender: Any) -> Bool {
        
        return true
    }
    
    
    @IBAction func startUpChecked(_ sender: NSButton) {
        self.toggleLaunchAtStartup()
    }
    
    
    ///////////////////////////////////////////////////// 旧式的登陆启动 ////////////////////////////////////
    func isInStartUpItems() -> Bool {
        return (itemReferencesInLoginItems().existingReference != nil)
    }
    
    
    func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItem?, lastReference: LSSharedFileListItem?) {
        let itemUrl : UnsafeMutablePointer<Unmanaged<CFURL>?> = UnsafeMutablePointer<Unmanaged<CFURL>?>.allocate(capacity: 1)
        if let appUrl : NSURL = NSURL.fileURL(withPath: Bundle.main.bundlePath) as NSURL? {
            let loginItemsRef = LSSharedFileListCreate(
                nil,
                kLSSharedFileListSessionLoginItems.takeRetainedValue(),
                nil
                ).takeRetainedValue() as LSSharedFileList?
            if loginItemsRef != nil {
                let loginItems: NSArray = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
                print("There are \(loginItems.count) login items")
                let lastItemRef: LSSharedFileListItem = loginItems.lastObject as! LSSharedFileListItem
                for i in 0 ..< loginItems.count {
                    let currentItemRef: LSSharedFileListItem = loginItems.object(at: i) as! LSSharedFileListItem
                    if LSSharedFileListItemResolve(currentItemRef, 0, itemUrl, nil) == noErr {
                        if let urlRef: NSURL =  itemUrl.pointee?.takeRetainedValue() {
                           // print("URL Ref: \(urlRef.lastPathComponent)")
                            if urlRef.isEqual(appUrl) {
                                return (currentItemRef, lastItemRef)
                            }
                        }
                    } else {
                        print("Unknown login application")
                    }
                }
                return (nil, lastItemRef)
            }
        }
        return (nil, nil)
    }
    
    func toggleLaunchAtStartup() {
        let itemReferences = itemReferencesInLoginItems()
        let shouldBeToggled = (itemReferences.existingReference == nil)
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileList?
        if loginItemsRef != nil {
            if shouldBeToggled {
                if let appUrl : CFURL = NSURL.fileURL(withPath: Bundle.main.bundlePath) as CFURL? {
                    LSSharedFileListInsertItemURL(
                        loginItemsRef,
                        itemReferences.lastReference,
                        nil,
                        nil,
                        appUrl,
                        nil,
                        nil
                    )
                    print("Application was added to login items")
                }
            } else {
                if let itemRef = itemReferences.existingReference {
                    LSSharedFileListItemRemove(loginItemsRef,itemRef);
                    print("Application was removed from login items")
                }
            }
        }
    }
    ///////////////////////////////////////////////////// 旧式的登陆启动 ////////////////////////////////////
    
    
    
    override var windowNibName: String? {
        return "SettingWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // 设置自启动复选框的状态
        if isInStartUpItems() {
            startUpCheckBtn.state = 1
        } else {
            startUpCheckBtn.state = 0
        }
        
        // 读取本地记录的颜色信息
        if let data = UserDefaults.standard.value(forKey: SettingWindowController.HOLIDAY_COLOR_TAG) {
            let color = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! NSColor
            holidayColorWell.color = color
        } else {
            holidayColorWell.color = .red
        }
        if let data = UserDefaults.standard.value(forKey: SettingWindowController.FESTIVAL_COLOR_TAG) {
            let color = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! NSColor
            festivalColorWell.color = color
        } else {
            festivalColorWell.color = .black
        }
        
    }
}
