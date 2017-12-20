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
    var mExtraInfo: String = ""
    override func draw(_ dirtyRect: NSRect) {
        
        let bezierPath = NSBezierPath()
        let leftTop = NSPoint(x: 0, y: 0)
        let leftBottom = NSPoint(x: 0, y: 15)
        let middleBottom = NSPoint(x:5, y: 5)
        let rightBottom = NSPoint(x: 10, y: 15)
        let rightTop = NSPoint(x: 10, y: 0)
        bezierPath.move(to: leftBottom)
        bezierPath.line(to: leftTop)
        bezierPath.line(to: middleBottom)
        bezierPath.line(to: rightTop)
        bezierPath.line(to: rightBottom)
        bezierPath.close()
        
        mBackgroundColor.set()
        bezierPath.fill()
        
        let info: NSString = mExtraInfo as NSString
        let md = NSMutableDictionary()
        md.setObject(NSFont.systemFont(ofSize: 8), forKey: NSFontAttributeName as NSCopying)
        md.setObject(NSColor.white, forKey: NSForegroundColorAttributeName as NSCopying)
        info.draw(at: NSPoint(x: 1, y: 5), withAttributes: (md as! [String : Any]))
    }
    
    init(color: NSColor, frame: NSRect, extra: String) {
        super.init(frame: frame)
        mBackgroundColor = color
        mExtraInfo = extra
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
