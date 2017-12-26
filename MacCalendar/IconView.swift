//
//  IconView.swift
//  MacCalendar
//
//  Created by bugcode on 2016/9/21.
//  Copyright © 2016年 bugcode. All rights reserved.
//


import Foundation
import Cocoa


class IconView : NSView, NSUserNotificationCenterDelegate
{
    private(set) var image: NSImage
    private let item: NSStatusItem
    
    var mCurWeek: Int = 0
    var timer: Timer?
    var isDraw: Bool = false
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
        var rect = CGRect(x: 2, y: 2, width: size.width, height: size.height - 5.5)

        dayString.draw(in: rect, withAttributes: dayAttrDict)
        
        // 星期文字
        let weekAttrDict = [NSAttributedStringKey.foregroundColor : NSColor.white, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : NSFont.systemFont(ofSize: 3.8)]
        let weekString = NSString(string: week)
        rect = CGRect(x: 2, y: 2.5, width: size.width, height: size.height)
        weekString.draw(in: rect , withAttributes: weekAttrDict)
    }
    
    init(imageName: String, item: NSStatusItem) {
        let thickness = NSStatusBar.system.thickness

        self.image = NSImage(named: NSImage.Name(rawValue: imageName))!
        self.item = item
        self.item.highlightMode = true
        self.isSelected = false
        self.onMouseDown = {}
        
        let rect = CGRect(x: 0, y: 0, width: thickness, height: thickness)
        
        super.init(frame: rect)
        
        // 图标上加入文本
        addTextToImage()
        
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(IconView.reDraw), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    // 日期提醒推送通知
    func pushNotification(year: Int, month: Int, day: Int) -> Bool {
        let info = LocalDataManager.sharedInstance.getCurDateFlag(wzDay: CalendarUtils.WZDayTime(year, month, day))
        let notification = NSUserNotification()
        notification.title = String(year) + "-" + String(month) + "-" + String(day) +  " 提醒备注"
        notification.informativeText = info
        
        notification.deliveryDate = Date(timeIntervalSinceNow: 10)
        var dateComponent = DateComponents()
        dateComponent.second = 60 * 60 * 12
        notification.deliveryRepeatInterval = dateComponent
        
        notification.hasActionButton = true
        notification.actionButtonTitle = "确定"
        notification.otherButtonTitle = "忽略"
        
        NSUserNotificationCenter.default.delegate = self
        NSUserNotificationCenter.default.scheduledNotifications = [notification]
        
        
        for i in NSUserNotificationCenter.default.scheduledNotifications {
            NSUserNotificationCenter.default.removeScheduledNotification(i)
        }
        
        
        return true
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
}
