//
//  IconView.swift
//  MacCalendar
//
//  Created by bugcode on 2016/9/21.
//  Copyright © 2016年 bugcode. All rights reserved.
//


import Foundation
import Cocoa

extension NSImage {
    convenience init(color: NSColor, size: NSSize) {
        self.init(size: size)
        lockFocus()
        color.drawSwatch(in: NSRect(origin: .zero, size: size))
        unlockFocus()
    }
}


class IconView : NSView
{
    private(set) var image: NSImage
    private let item: NSStatusItem
    
    var onMouseDown: () -> ()
    
    var isSelected: Bool {
        didSet
        {
            if (isSelected != oldValue)
            {
                self.needsDisplay = true
            }
        }
    }
    
    // 在image上添加文本
    func addTextToImage(image: inout NSImage, day: String, week: String) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        // 日期文本
        let dayAttrDict = [NSForegroundColorAttributeName : NSColor.black, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 9.8)]
        image.lockFocus()
        let dayString = NSString(string: day)
        var pos = NSPoint(x: image.size.width / 2 - dayString.size(withAttributes: dayAttrDict).width / 2, y: 0.5)
        dayString.draw(at: pos, withAttributes: dayAttrDict)
        
        // 星期文字
        let weekAttrDict = [NSForegroundColorAttributeName : NSColor.white, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 3.8)]
        let weekString = NSString(string: week)
        pos = NSPoint(x: image.size.width / 2 - weekString.size(withAttributes: weekAttrDict).width / 2, y: 12.5)
        weekString.draw(at: pos, withAttributes: weekAttrDict)
        
        image.unlockFocus()
    }
    
    
    init(imageName: String, item: NSStatusItem) {
        let thickness = NSStatusBar.system().thickness

        var image = NSImage(named: imageName)!
        
        self.image = image
        self.item = item
        self.item.highlightMode = true
        self.isSelected = false
        self.onMouseDown = {}
        
        let rect = CGRect(x: 0, y: 0, width: thickness, height: thickness)
        
        super.init(frame: rect)
        
        let util = CalendarUtils.sharedInstance
        let (year, month, day) = util.getYMDTuppleBy(util.getDateStringOfToday())
        let week = util.getWeekDayBy(year, month: month, day: day)
        
        // 图标上加入文本
        addTextToImage(image: &image, day: String(day), week: String(CalendarConstant.WEEK_SHORT_CUT[week]))
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        self.item.drawStatusBarBackground(in: dirtyRect, withHighlight: self.isSelected)
        
        self.item.title = "Cal"
        let size = self.image.size
        let rect = CGRect(x: 2, y: 2, width: size.width, height: size.height)
        
        self.image.draw(in: rect)
    }
    
    override func mouseDown(with event: NSEvent) {
        self.isSelected = !self.isSelected;
        self.onMouseDown();
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }
}
