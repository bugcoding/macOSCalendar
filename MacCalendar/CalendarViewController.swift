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
    
    // 右侧显示区
    @IBOutlet weak var dateDetailLabel: NSTextField!
    @IBOutlet weak var dayLabel: NSTextField!

    
    // 日历类实例
    var mCalendar: LunarCalendarUtils = LunarCalendarUtils()
    var mCurMonth: Int = 0
    
    // 每个显示日期的单元格
    var cellBtns = [CalendarCellView]()
    var lastRowNum:Int = 0
    
    override var windowNibName: String?{
        return "CalendarViewController"
    }
    
    // MARK: Button handler
    @IBAction func lastMonthHandler(_ sender: NSButton) {
        let utils = CalendarUtils.sharedInstance
    
        let newYearMonth = utils.getMonthDateStringBy(year: Int(yearText.stringValue)!, month: Int(monthText.stringValue)!, step: -1)
        showMonthPanel(year: newYearMonth.year, month: newYearMonth.month)
    }
    
    @IBAction func nextMonthHandler(_ sender: NSButton) {
        let utils = CalendarUtils.sharedInstance
        
        let newYearMonth = utils.getMonthDateStringBy(year: Int(yearText.stringValue)!, month: Int(monthText.stringValue)!, step: 1)
        showMonthPanel(year: newYearMonth.year, month: newYearMonth.month)
    }

    @IBAction func nextYearHandler(_ sender: NSButton) {
    }
    
    @IBAction func lastYearHandler(_ sender: NSButton) {
    }
    
    // 打开界面是默认显示今天
    func showDefaultDate() {
        let utils = CalendarUtils.sharedInstance
        showDaysInFormsBy(utils.getDateStringOfToday())
    }
    
    func showMonthPanel(year: Int, month: Int) {
        let utils = CalendarUtils.sharedInstance
        // 根据日期字符串获取当前月共有多少天
        let monthDays = utils.getDaysBy(year: year, month: month)
        
        // 显示上方二个区域的年份与月份信息
        yearText.stringValue = String(year)
        monthText.stringValue = String(month)
        // 上个月有多少天
        var lastMonthDays = 0
        if month == 1 {
            lastMonthDays = utils.getDaysBy(year: year - 1, month: 12)
        } else {
            lastMonthDays = utils.getDaysBy(year: year, month: month - 1)
        }
        
        
        // 本月第一天与最后一天是周几
        let weekDayOf1stDay = utils.getWeekBy(year: year, month: month, andFirstDay: 1)
        let weekDayOfLastDay = utils.getWeekBy(year: year, month: month, andFirstDay: monthDays)
        
        print("dateString = \(year)-\(month) weekOf1stDay = \(weekDayOf1stDay) weekOfLastDay = \(weekDayOfLastDay) monthDays = \(monthDays) ")
        
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
                    btn.setString(topText: "\(index - monthDays - weekDayOf1stDay + 1)", topColor: .black, bottomText: "初一", bottomColor: NSColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1))
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
            }
            
        }

    }
    
    // 显示日历面板
    func showDaysInFormsBy(_ dateString: String){
        // 获取每月第一天是周几
        let utils = CalendarUtils.sharedInstance

        let dateTupple = utils.getYMDTuppleBy(dateString)
        
        dayLabel.stringValue = String(dateTupple.day)
        
        let curWeekDay = utils.getWeekBy(year: dateTupple.year, month: dateTupple.month, andFirstDay: dateTupple.day)
        dateDetailLabel.stringValue = String(dateTupple.year) + "年" + String(dateTupple.month) + "月" + String(dateTupple.day) + "日 星期" + CalendarConstant.WEEK_NAME_OF_CHINESE[curWeekDay]
        
        showMonthPanel(year: dateTupple.year, month: dateTupple.month)
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
    
    
    func showLuarCalendar() {
        var stems: Int = 0, branches: Int = 0, sbMonth:Int = 0, sbDay:Int = 0
        let year = mCalendar.getCurrentYear()
        mCalendar.getSpringBeginDay(month: &sbMonth, day: &sbDay)
        CalendarUtils.sharedInstance.calculateStemsBranches(year: (mCurMonth >= sbMonth) ? year : year - 1, stems: &stems, branches: &branches)
        
        print("\(year) 年 \(mCurMonth) 月  农历 \(CalendarConstant.HEAVENLY_STEMS_NAME[stems]) \(CalendarConstant.EARTHY_BRANCHES_NAME[branches]) \(CalendarConstant.CHINESE_ZODIC_NAME[branches])")
    }
    
    func showDateCells() {
        if mCalendar.isCalendarReady() {
            let mi = mCalendar.getMonthInfo(month: mCurMonth)
            
            for i in 1 ... mi.mInfo.days {
                let dayInfo = mi.getDayInfo(day: i)
                
            }
        }
    }
    
    
    func setCurrenMonth(month: Int) {
        if month >= 1 && month <= CalendarConstant.MONTHES_FOR_YEAR {
            mCurMonth = month
            showLuarCalendar()
            showDateCells()
            
        }
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
        // self.showDefaultDate()
        let date = CalendarUtils.sharedInstance.getDateStringOfToday()
        let dateTupple = CalendarUtils.sharedInstance.getYMDTuppleBy(date)
        
        if mCalendar.setGeriYear(year: dateTupple.year) {
            setCurrenMonth(month: dateTupple.month)
            
        }
    }
    
}
