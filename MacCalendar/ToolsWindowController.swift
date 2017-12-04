//
//  ToolWindowController.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/3.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Cocoa
class ToolsWindowController : NSWindowController, NSWindowDelegate {

    // 公历转农历
    @IBOutlet weak var gori2Lunar: NSButton!
    // 农历转公历
    @IBOutlet weak var lunar2Gori: NSButton!
    // 转换按钮
    @IBOutlet weak var transButton: NSButton!
    // 当前是哪种模式
    private var mode:Int8 = 0;
    
    // 农历转公历选中
    @IBAction func lunarOrGoriSelected(_ sender: NSButton) {
        if sender == gori2Lunar && sender.state == 1 {
            mode = 1
        } else {
            mode = 0
        }
        print("mode == \(mode)")
    }
    
    @IBAction func transformDate(_ sender: NSButton) {
        print("transform button pressed")
    }
    override var windowNibName: String? {
        return "ToolsWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        gori2Lunar.state = 1
        lunar2Gori.state = 0
    }
    
}
