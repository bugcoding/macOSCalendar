//
//  ReminderTipWindowController.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/10.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Cocoa

class ReminderTipViewController : NSViewController {
    
    @IBOutlet var mainView: NSView!

    // 加载view
    override func loadView() {
        var tlp : NSArray = NSArray()
        if Bundle.main.loadNibNamed("ReminderTipViewController", owner: self, topLevelObjects: &tlp) {
            mainView = tlp.first(where: { $0 is NSView }) as? NSView
        }
    }

}
