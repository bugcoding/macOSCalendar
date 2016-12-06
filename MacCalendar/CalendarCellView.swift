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
    var mCellID: Int = 0
    var mBgColor: NSColor = NSColor.white
    var mCurDay: Int = -1
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isBordered = false
        self.wantsLayer = true
        self.layer!.backgroundColor = self.mBgColor.cgColor
    }
    
    func setBackGroundColor(bgColor: NSColor) {
        self.mBgColor = bgColor
        self.wantsLayer = true
        self.layer!.backgroundColor = self.mBgColor.cgColor
    }
    
    // 显示具体的农历和公历，设置具体button的标题属性
    func setString(geriMonth: Int, geriDay: Int, topColor: NSColor, monthInfo: MonthInfo, chmInfo: ChnMonthInfo, bottomText: String, bottomColor: NSColor) {
        
        mCurDay = geriDay
        
        let dayInfo = monthInfo.getDayInfo(day: geriDay)
        Swift.print("setString geriMonth = \(geriMonth) geriDay = \(geriDay) dayInfo = \(dayInfo.mmonth) \(dayInfo.mdayNo)")
        // 居中样式
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let topText = String(geriDay) + "\n"
        var holidayText = ""
        
        
        let holidayName = CalendarUtils.sharedInstance.getHolidayNameBy(month: geriMonth, day: geriDay)
        if holidayName != "" && holidayName.characters.count <= 4 {
            holidayText = holidayName
        }
        
        // 如果有农历节日，优先显示农历节日
        let festivalName = CalendarUtils.sharedInstance.getLunarFestivalNameBy(month: chmInfo.mInfo.mname, day: dayInfo.mdayNo + 1)
        if festivalName != "" {
            holidayText = festivalName
        }
        
        if holidayText == "" {
            holidayText = bottomText
        }

        let goriDayDict = [NSForegroundColorAttributeName : topColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 18.0)]
        let lunarDayDict = [NSForegroundColorAttributeName : bottomColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 9.0)]
        
        let goriAttrDay = NSAttributedString(string: (topText as NSString).substring(with: NSMakeRange(0, topText.characters.count)), attributes: goriDayDict)
        let lunarAttrDay = NSAttributedString(string: (holidayText as NSString).substring(with: NSMakeRange(0, holidayText.characters.count)), attributes: lunarDayDict)

        let finalAttr = NSMutableAttributedString(attributedString: goriAttrDay)
        finalAttr.append(lunarAttrDay)
        
        self.attributedTitle = finalAttr
    }
    
}
