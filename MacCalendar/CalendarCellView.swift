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
    var cellID: Int = 0
    var label: NSTextField?
    
    // 显示具体的农历和公历，设置具体button的标题属性
    func setString(day:Int, lunarString:String) {
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let finalString = String(day) + "\n" + lunarString

        let goriDayDict = [NSForegroundColorAttributeName : NSColor.black, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 20.0)]
        let lunarDayDict = [NSForegroundColorAttributeName : NSColor.blue, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 10.0)]
        
        let goriAttrDay = NSAttributedString(string: (finalString as NSString).substring(with: NSMakeRange(0, 2)), attributes: goriDayDict)
        let lunarAttrDay = NSAttributedString(string: (finalString as NSString).substring(with: NSMakeRange(2, 2)), attributes: lunarDayDict)

        let finalAttr = NSMutableAttributedString(attributedString: goriAttrDay)
        finalAttr.append(lunarAttrDay)
        
        self.attributedTitle = finalAttr
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}
