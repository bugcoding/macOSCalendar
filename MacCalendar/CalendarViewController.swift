//
//  CalendarViewController.swift
//  MacCalendar
//
//  Created by bugcode on 16/7/16.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CalendarViewController: NSWindowController {
    
    // MARK: - Outlets define
    
    // 年和月上的箭头
    @IBOutlet weak var nextYearBtn: NSButton!
    @IBOutlet weak var lastYearBtn: NSButton!
    @IBOutlet weak var nextMonthBtn: NSButton!
    @IBOutlet weak var lastMonthBtn: NSButton!
    
    // 顶部三个label
    @IBOutlet weak var yearText: NSTextField!
    @IBOutlet weak var monthText: NSTextField!
    @IBOutlet weak var dayText: NSTextField!
    
    // 右侧显示区
    @IBOutlet weak var dateDetailLabel: NSTextField!
    @IBOutlet weak var dayLabel: NSTextField!

    
    // 每个显示日期的单元格
    var cellBtns = [CalendarCellView]()
    var lastRowNum:Int = 0
    
    override var windowNibName: String?{
        return "CalendarViewController"
    }
    
    // MARK: Button handler
    @IBAction func leftArrowBtnHandler(_ sender:AnyObject){
        //selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: -1)
        //showDaysInFormsBy(selectDataText.stringValue)
    }
    
    @IBAction func rightArrowBtnHandler(_ sender:AnyObject){
        //selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: 1)
        //showDaysInFormsBy(selectDataText.stringValue)
    }
    
    @IBAction func lastMonthHandler(_ sender: NSButton) {
        monthText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(monthText.stringValue, step: -1)
    }
    
    @IBAction func nextMonthHandler(_ sender: NSButton) {
    }

    @IBAction func nextYearHandler(_ sender: NSButton) {
    }
    
    @IBAction func lastYearHandler(_ sender: NSButton) {
    }
    
    // 打开界面是默认显示今天
    func showDefaultDate() {
        let utils = CalendarUtils.sharedInstance
        // 文本框里显示当前日期
        //selectDataText.stringValue = utils.getDateStringOfToday()
        showDaysInFormsBy(utils.getDateStringOfToday())
    }
    
    // 显示日历面板
    func showDaysInFormsBy(_ dateString: String){
        // 获取每月第一天是周几
        let utils = CalendarUtils.sharedInstance

        let dateTupple = utils.getYMDTuppleBy(dateString)
        // 今天的日
        let currentDay = dateTupple.day
        // 根据日期字符串获取当前月共有多少天
        let monthDays = utils.getDaysBy(year: dateTupple.year, month: dateTupple.month)
        
        // 上个月有多少天
        var lastMonthDays = 0
        if dateTupple.month == 1 {
            lastMonthDays = utils.getDaysBy(year: dateTupple.year - 1, month: 12)
        } else {
            lastMonthDays = utils.getDaysBy(year: dateTupple.year, month: dateTupple.month - 1)
        }
        
        
        // 本月第一天与最后一天是周几
        let weekDayOf1stDay = utils.getWeekBy(dateString, andFirstDay: 1)
        let weekDayOfLastDay = utils.getWeekBy(dateString, andFirstDay: monthDays)
        
        print("dateString = \(dateString) weekOf1stDay = \(weekDayOf1stDay) weekOfLastDay = \(weekDayOfLastDay) monthDays = \(monthDays) ")
        
        // 把空余不的cell行不显示，非本月天置灰
        for (index, btn) in cellBtns.enumerated() {
            
            print("showDaysInFormsBy index = \(index)")
            btn.isEnabled = true
            btn.isTransparent = false
            
            if index < weekDayOf1stDay || index >= monthDays + weekDayOf1stDay {
                let curRowNum = Int((btn.cellID - 1) / 7) + 1
                // 最后一行空出来
                if index >= monthDays + weekDayOf1stDay && curRowNum > lastRowNum {
                    btn.isTransparent = true
                }else{
                    btn.isEnabled = false
                }
                // 处理前后二个月的显示日期 (灰置部分)
                if index < weekDayOf1stDay {
                    btn.setString(topText: "\(lastMonthDays - weekDayOf1stDay + index + 1)", topColor: .black, bottomText: "初一", bottomColor: NSColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1))
                }else {
                    btn.setString(topText: "\(index - monthDays)", topColor: .black, bottomText: "初一", bottomColor: NSColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1))
                }

            } else {
                if index == monthDays + weekDayOf1stDay - 1 {
                    // 当前cell在第几行
                    lastRowNum = Int((btn.cellID - 1) / 7) + 1
                    print("currentRowNumber = \(lastRowNum)")

                }
                
                let day = index - weekDayOf1stDay + 1
                //btn.title = "\(index - weekDayOf1stDay + 1)"
                btn.setString(topText: "\(day)", topColor: .black, bottomText: "初一", bottomColor: NSColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1))

                
                // 处理周六日的日期颜色
                if index % 7 == 6 || index % 7 == 0 {
                    btn.setString(topText: "\(day)", topColor: .red, bottomText: "初一", bottomColor: .red)
                }
                
                // 设置当前日期的颜色 TODO: 
                if day == currentDay {
                    btn.setBackGroundColor(bgColor: .green)
                }
            }

        }
    }
    
    
    
    // 根据xib中的identifier获取对应的cell
    func getButtonByIdentifier(_ id:String) -> NSView? {
        for subView in (self.window?.contentView?.subviews[0].subviews)! {
            if subView.identifier == id {
                return subView
            }
        }
        return nil
    }
    
    
    func dateButtonHandler(_ sender:NSButton){
        print("Press Button is \(sender.identifier)")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // 将所有cell加入数组管理，并加入回调逻辑
        for i in 0 ... 5 {
            for j in 0 ... 6 {
                let intValue = (i * 7 + j + 1)
                let id = "cell\(intValue)"
                if let btn = self.getButtonByIdentifier(id) {
                    let cellBtn = btn as! CalendarCellView
                    cellBtn.target = self
                    cellBtn.action = #selector(CalendarViewController.dateButtonHandler(_:))
                    cellBtn.cellID = intValue
                    cellBtns.append(cellBtn)
                }
            }
        }
        
        for (index, btn) in cellBtns.enumerated() {
            print("cellbtns index = \(index) btn.action = \(btn.action) btn.intValue = \(btn.cellID)")
        }
        
        // 加载完窗口显示默认
        self.showDefaultDate()
        
    }
    
}
