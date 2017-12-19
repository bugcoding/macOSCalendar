//
//  CornerFlagView.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/19.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Cocoa

class CornerFlagView : NSView {
    // 背景设置之后，马上重绘整个背景
    var mBackgroundColor: NSColor = NSColor.white {
        didSet {
            needsDisplay = true
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        NSColor.red.set()
        NSBezierPath.fill(self.frame)
    }
    
    init(color: NSColor, frame: NSRect) {
        super.init(frame: frame)
        mBackgroundColor = color
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
