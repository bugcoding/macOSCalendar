//
//  CalendarCellView.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/17.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CalendarCellView : NSButton{
    // 标识具体的cell
    var cellID:Int = 0
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}
