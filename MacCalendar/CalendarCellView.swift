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
    var bgColor: NSColor?
    
    func setBackGroundColor(bgColor: NSColor) {
        self.bgColor = bgColor
    }
    
    // 显示具体的农历和公历，设置具体button的标题属性
    func setString(topText: String, topColor: NSColor, bottomText: String, bottomColor: NSColor) {
        
        // 居中样式
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let topText = topText + "\n"

        let goriDayDict = [NSForegroundColorAttributeName : topColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 20.0)]
        let lunarDayDict = [NSForegroundColorAttributeName : bottomColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 10.0)]
        
        let goriAttrDay = NSAttributedString(string: (topText as NSString).substring(with: NSMakeRange(0, topText.characters.count)), attributes: goriDayDict)
        let lunarAttrDay = NSAttributedString(string: (bottomText as NSString).substring(with: NSMakeRange(0, bottomText.characters.count)), attributes: lunarDayDict)

        let finalAttr = NSMutableAttributedString(attributedString: goriAttrDay)
        finalAttr.append(lunarAttrDay)
        
        self.attributedTitle = finalAttr
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}
