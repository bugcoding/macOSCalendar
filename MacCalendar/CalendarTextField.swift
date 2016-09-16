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
        if window?.firstResponder == currentEditor() && NSApp.isActive {
            NSGraphicsContext.saveGraphicsState()
            NSSetFocusRingStyle(.only)
            NSGraphicsContext.restoreGraphicsState()
        } else {
            super.draw(dirtyRect)
        }
    }
}
