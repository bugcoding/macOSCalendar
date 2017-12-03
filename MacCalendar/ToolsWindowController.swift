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
    
    // 当前是哪种模式
    private let mode:Int8 = 0;
    
    // 农历转公历选中
    @IBAction func lunar2GoriSelected(_ sender: NSButton) {
        
    }
    // 公历转农历选中
    @IBAction func gori2LunarSelected(_ sender: NSButton) {
    }
}
