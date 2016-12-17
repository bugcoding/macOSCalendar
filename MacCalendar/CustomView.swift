//
//  CustomView.swift
//  StatebarCalendar
//
//  Created by bugcode on 2016/12/17.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CustomView: NSView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        // 圆角矩形
        self.layer?.cornerRadius = 3
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let color = NSColor(calibratedWhite: 0.93, alpha: 1.0)
        color.set()
        
        NSRectFill(dirtyRect)
    }
    
}
