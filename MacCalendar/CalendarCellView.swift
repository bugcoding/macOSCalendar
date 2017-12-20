//
//  CalendarCellView.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/17.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CalendarCellView : NSButton, NSMenuDelegate{
    // 标识具体的cell
    var mCellID: Int = 0
    var mBgColor: NSColor = .white
    let mPopoverWindow = NSPopover()
    // 当前是哪月
    var wzDay: CalendarUtils.WZDayTime = CalendarUtils.WZDayTime(0, 0, 0)
    // 当前是否是带标记日期
    var mIsFlagDate: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.cell = CalendarViewCell(coder: coder)

        self.isBordered = false
        self.wantsLayer = true
        self.layer!.backgroundColor = self.mBgColor.cgColor
        
        // 设置鼠标进出跟踪区域
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingArea.Options.activeAlways,NSTrackingArea.Options.mouseEnteredAndExited], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        

    }
    
    func setBackGroundColor(bgColor: NSColor) {
        self.mBgColor = bgColor
        self.wantsLayer = true
        self.layer!.backgroundColor = self.mBgColor.cgColor
    }
    
    // 关闭popover
    func performPopoverClose() {
        mPopoverWindow.performClose(nil)
    }
    
    // 弹出popover
    func showPopoverView(content: String) {
        let viewController = ReminderTipViewController(date: wzDay, view: self, content: content)
        mPopoverWindow.contentSize = viewController.view.fittingSize
        mPopoverWindow.contentViewController = viewController
        // 失去焦点时关闭
        mPopoverWindow.behavior = .transient
        mPopoverWindow.show(relativeTo: self.bounds, of: self, preferredEdge: NSRectEdge.minY)
    }
    
    // 添加日期标记
    func addFlagHandler(_ sender:CalendarCellView) {
        Swift.print("cur wzTime = \(wzDay.year)-\(wzDay.month)-\(wzDay.day)")
        showPopoverView(content: "")
    }
    // 移除日期标记
    func removeFlagHandler(_ sender:CalendarCellView) {
        Swift.print("cur wzTime = \(wzDay.year)-\(wzDay.month)-\(wzDay.day)")
        let dateStr = String(describing: wzDay.year) + String(describing: wzDay.month) + String(describing: wzDay.day)
        LocalDataManager.sharedInstance.removeData(forKey: dateStr)
        
    }
    // 在当前日期已有标记的情况下，显示编辑日期标志
    func editFlagHandler(_ sender:CalendarCellView) {
        Swift.print("editFlagHandler")
        showPopoverView(content: getCurDateFlag())
    }
    // 修改当前日期边框颜色
    func changeBorderColor(borderWid: CGFloat, color: NSColor) {
        if self.isEnabled {
            self.layer?.borderWidth = borderWid
            self.layer?.borderColor = color.cgColor
        }
    }
    
    // 创建右键菜单
    func createRightMouseMenu(_ event: NSEvent) {
        
        let popMenu = NSMenu()
        popMenu.delegate = self
        var addFlagItem = NSMenuItem(title: "标记当前日期", action: #selector(CalendarCellView.addFlagHandler(_:)), keyEquivalent: "")
        let info = getCurDateFlag()
        if info != "" {
            // 当前日期有标记
            addFlagItem = NSMenuItem(title: "编辑日期标记", action: #selector(CalendarCellView.editFlagHandler(_:)), keyEquivalent: "")
        }

        popMenu.addItem(addFlagItem)
        let removeFlagItem = NSMenuItem(title: "移除标记日期", action: #selector(CalendarCellView.removeFlagHandler(_:)), keyEquivalent: "")
        popMenu.addItem(removeFlagItem)
        NSMenu.popUpContextMenu(popMenu, with: event, for: self)
    }
    
    override func mouseExited(with event: NSEvent) {
        changeBorderColor(borderWid: 0, color: self.mBgColor)
    }
    
    override func mouseEntered(with event: NSEvent) {
        changeBorderColor(borderWid: 0.9, color: CalendarConstant.selectedDateColor)
    }
    
    // 右键点击格子弹出菜单
    override func rightMouseDown(with event: NSEvent) {
        // 显示右键菜单
        createRightMouseMenu(event)
    }
    
    // 获取当前日期是否有标记
    func getCurDateFlag() -> String {
        let str = String(describing: wzDay.year) + String(describing: wzDay.month) + String(describing: wzDay.day)
        //Swift.print("wzDay = \(str)")
        
        if let data = LocalDataManager.sharedInstance.popData(forKey: str) {
            let info = NSKeyedUnarchiver.unarchiveObject(with: data) as! String
            return info
        }
        return ""
    }
    
    // 显示具体的农历和公历，设置具体button的标题属性
    func setString(wzTime: CalendarUtils.WZDayTime, topColor: NSColor, bottomText: String, bottomColor: NSColor) {
        
        wzDay = wzTime
        mIsFlagDate = false
        // 已标记过的日期，用橙色显示
        let info = getCurDateFlag()
        if info != "" {
            let color = NSColor(calibratedRed: NSColor.red.redComponent, green: NSColor.red.greenComponent, blue: NSColor.red.blueComponent, alpha: 0.5)
            //setBackGroundColor(bgColor: color)
            let cfv = CornerFlagView(color: color, frame: NSRect(x: 38, y: 0, width: 48, height: 15), extra: "备")
            addSubview(cfv)
            self.toolTip = "备注: " + info
            mIsFlagDate = true
        }
        
        // 居中样式
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let topText = String(wzDay.day) + "\n"

        let goriDayDict = [NSForegroundColorAttributeName : topColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 18.0)]
        let lunarDayDict = [NSForegroundColorAttributeName : bottomColor, NSParagraphStyleAttributeName : style, NSFontAttributeName : NSFont.systemFont(ofSize: 9.0)]
        
        let goriAttrDay = NSAttributedString(string: (topText as NSString).substring(with: NSMakeRange(0, topText.count)), attributes: goriDayDict)
        let lunarAttrDay = NSAttributedString(string: (bottomText as NSString).substring(with: NSMakeRange(0, bottomText.count)), attributes: lunarDayDict)

        let finalAttr = NSMutableAttributedString(attributedString: goriAttrDay)
        finalAttr.append(lunarAttrDay)
        
        self.attributedTitle = finalAttr
    }
    
    
}
