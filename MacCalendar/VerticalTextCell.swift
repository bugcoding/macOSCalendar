//
//  VerticalTextCell.swift
//  StatebarCalendar
//
//  Created by bugcode on 2018/1/1.
//  Copyright © 2018年 bugcode. All rights reserved.
//

import Cocoa

class VertivalTextCell: NSTextFieldCell {
    
    override func drawingRect(forBounds theRect: NSRect) -> NSRect {
        let newRect = NSRect(x: 0, y: (theRect.size.height - 22) / 2, width: theRect.size.width, height: 22)
        let color = NSColor(calibratedRed: 210, green: 234, blue: 153, alpha: 0.6)
        color.set()
        theRect.fill()
        return super.drawingRect(forBounds: newRect)
    }
    
    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.draw(withFrame: titleRect(forBounds: cellFrame), in: controlView)
    }
}
