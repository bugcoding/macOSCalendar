//
//  SettingMenu.swift
//  StatebarCalendar
//
//  Created by bugcode on 2016/12/10.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class SettingMenu: NSMenu {

    init() {
        super.init(title: "Setting")
        let set = self.insertItem(withTitle: "自启动", action: #selector(SettingMenu.setting(_:)), keyEquivalent: "", at: 0)
        set.target = self
        if isInStartUpItems() {
            set.state = NSOnState
        } else {
            set.state = NSOffState
        }
        
        let ab = self.insertItem(withTitle: "关于", action: #selector(SettingMenu.about(_:)), keyEquivalent: "", at: 1)
        ab.target = self
        let qt = self.insertItem(withTitle: "退出", action: #selector(SettingMenu.quit(_:)), keyEquivalent: "", at: 2)
        qt.target = self
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                            print("URL Ref: \(urlRef.lastPathComponent)")
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

    
    func setting(_ sender: NSMenuItem){
        if sender.state == NSOffState {
            sender.state = NSOnState
        } else {
            sender.state = NSOffState
        }
        self.toggleLaunchAtStartup()
        
    }
    func about(_ sender: NSMenuItem) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let abbr = [ NSForegroundColorAttributeName: NSColor.black , NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 11.0)]
        
        let infoAttributedStr = NSAttributedString(string: "report: bugcoding@hotmail.com", attributes: abbr)
        
        NSApp.orderFrontStandardAboutPanel(options: ["Credits":infoAttributedStr])
    }
    func quit(_ sender: NSMenuItem) {
        NSApp.terminate(nil)
    }
}
