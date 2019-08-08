//
//  StatusBarView.swift
//  StatebarCalendar
//
//  Created by bugcode on 2019/8/3.
//  Copyright © 2019 bugcode. All rights reserved.
//

import Cocoa

class StatusBarView: NSView, NibLoadable {
    
    
    var image: NSImage = NSImage()
    var item: NSStatusItem = NSStatusItem()
    var timeLabel: NSTextField = NSTextField()
    
    var mCurWeek: Int = 0
    var timer: Timer = Timer()
    var timeTimer : Timer = Timer()
    var isDraw: Bool = false
    var onMouseDown: () -> () = {}

    var isSelected: Bool = false {
        didSet
        {
            if (isSelected != oldValue)
            {
                self.needsDisplay = true
            }
        }
    }
    
    // 在image上添加文本
    func addTextToImage() {
        let util = CalendarUtils.sharedInstance
        let (year, month, _day) = util.getYMDTuppleBy(util.getDateStringOfToday())
        let _week = util.getWeekDayBy(year, month: month, day: _day)
        let day = String(_day)
        let week = String(CalendarConstant.WEEK_SHORT_CUT[_week])
        mCurWeek = _week
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let size = self.image.size
        
        // 日期文本
        let dayAttrDict = [NSAttributedStringKey.foregroundColor : NSColor.black, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : NSFont.systemFont(ofSize: 9.8)]
        let dayString = NSString(string: day)
        var rect = CGRect(x: 2, y: 1.5, width: size.width, height: size.height - 5.5)
        
        dayString.draw(in: rect, withAttributes: dayAttrDict)
        
        // 星期文字
        let weekAttrDict = [NSAttributedStringKey.foregroundColor : NSColor.white, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : NSFont.systemFont(ofSize: 3.9)]
        let weekString = NSString(string: week)
        rect = CGRect(x: 2, y: 2.3, width: size.width, height: size.height)
        weekString.draw(in: rect , withAttributes: weekAttrDict)
        
        drawTimeString()
        
    }
    
    @objc func drawTimeString() {
        self.needsDisplay = true

        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let timeAttr = [NSAttributedStringKey.foregroundColor : NSColor.black, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : NSFont.systemFont(ofSize: 15.8)]
        let timeString = NSString(string: getCurrentTime())
        let rect = CGRect(x: 21, y: -2, width: 80, height: 22)
        timeString.draw(in: rect, withAttributes: timeAttr)
    }
    
    
    func getCurrentTime() -> String {
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE HH:mm"
        let convertedDate = dateFormatter.string(from: currentDate as Date)
        return convertedDate
    }
    
    
    func initItem(imageName: String, item: NSStatusItem) {
        
        self.image = NSImage(named: NSImage.Name(rawValue: imageName))!
        
        self.item = item
//        self.item.length = 100
        self.item.highlightMode = true
        self.isSelected = false
        self.onMouseDown = {}
        
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(StatusBarView.reDraw), userInfo: nil, repeats: true)
        
        timeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StatusBarView.drawTimeString), userInfo: nil, repeats: true)
    }
    
    @objc func reDraw() {
        let util = CalendarUtils.sharedInstance
        let (year, month, day) = util.getYMDTuppleBy(util.getDateStringOfToday())
        let week = util.getWeekDayBy(year, month: month, day: day)
        //pushNotification(year: year, month: month, day: day)
        NSUserNotificationCenter.default.removeAllDeliveredNotifications()
        if mCurWeek != week {
            mCurWeek = week
            addTextToImage()
            self.needsDisplay = true
            // 跨天之后，面板上的时间也要同步更新
            (NSApp.delegate as! AppDelegate).showToday()
            
        }
        
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        self.item.drawStatusBarBackground(in: dirtyRect, withHighlight: self.isSelected)
        
        let size = self.image.size
        let rect = CGRect(x: 2, y: 2, width: size.width, height: size.height)
        //self.image.draw(in: rect, from: NSRect.zero, operation:, fraction: 1.0)
        self.image.draw(in: rect, from: NSRect.zero, operation: NSCompositingOperation.destinationOver, fraction: 1.0)
        
        // 图标上加入文本
        addTextToImage()
    }
    
    override func mouseDown(with event: NSEvent) {
        self.isSelected = !self.isSelected;
        self.onMouseDown();
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

}
