//
//  CalendarTextField.swift
//  MacCalendar
//
//  Created by bugcode on 2016/9/16.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CalendarTextField: NSTextField {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // 不显示默认输入时的焦点与蓝色边框
        //NSSetFocusRingStyle(.only)
        //window!.makeFirstResponder(nil)
        //self.focusRingType = .none
    }
}
