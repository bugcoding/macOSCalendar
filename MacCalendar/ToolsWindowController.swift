//
//  ToolWindowController.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/3.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Cocoa
class ToolsWindowController : NSWindowController, NSWindowDelegate {

    // 公历转农历
    @IBOutlet weak var gori2Lunar: NSButton!
    // 农历转公历
    @IBOutlet weak var lunar2Gori: NSButton!
    // 转换按钮
    @IBOutlet weak var transButton: NSButton!
    // 当前是哪种模式
    private var mode:Int8 = 1;
    // 公历详情
    @IBOutlet weak var goriDetail: NSTextField!
    // 农历详情
    @IBOutlet weak var lunarDetail: NSTextField!
    
    // 年月日选择
    @IBOutlet weak var yearSelect: NSPopUpButton!
    @IBOutlet weak var monthSelect: NSPopUpButton!
    @IBOutlet weak var daySelect: NSPopUpButton!
    
    
    
    // 农历转公历选中
    @IBAction func lunarOrGoriSelected(_ sender: NSButton) {
        if sender == gori2Lunar && sender.state.rawValue == 1 {
            mode = 1
        } else {
            mode = 0
        }
        
        addPopUpItem()
        print("mode == \(mode)")
    }
    
    @IBAction func transformDate(_ sender: NSButton) {
        print("transform button pressed")
    }
    
    
    @IBAction func yearSelectedHandler(_ sender: NSPopUpButton) {
        let i  = sender.indexOfSelectedItem
        print("yearSelectedHandler i = \(i)")
    }
    
    @IBAction func monthSelectedHandler(_ sender: NSPopUpButton) {
        let month = sender.indexOfSelectedItem + 1
        let year = yearSelect.indexOfSelectedItem + 1900
        let days = CalendarUtils.sharedInstance.getDaysBy(year: year, month: month)
        
        // 年月选定，每个月多少天确定
        daySelect.removeAllItems()
        for i in 1 ... days {
            daySelect.addItem(withTitle: "\(i) 日")
        }
        
    }
    @IBAction func daySelectedHandler(_ sender: NSPopUpButton) {
    }
    
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("ToolsWindowController")
    }
    
    // 初始化公历日期与月份
    func initGoriPopupItems() {
        monthSelect.removeAllItems()
        for i in 1 ... 12 {
            monthSelect.addItem(withTitle: "\(i) 月")
        }
        daySelect.removeAllItems()
        for i in 1 ... 31 {
            daySelect.addItem(withTitle: "\(i) 日")
        }
    }
    // 初始化农历日期
    func initLunarPopupItems() {
        monthSelect.removeAllItems()
        for i in CalendarConstant.nameOfChnMonth {
            monthSelect.addItem(withTitle: i + "月")
        }
        daySelect.removeAllItems()
        for i in CalendarConstant.nameOfChnDay {
            daySelect.addItem(withTitle: i)
        }
    }
    
    // 添加年月日待选项
    func addPopUpItem() {
        yearSelect.removeAllItems()
        for i in 1900 ... 2100 {
            yearSelect.addItem(withTitle: "\(i)")
        }
        if mode == 1 {
            initGoriPopupItems()
        } else if mode == 0 {
            initLunarPopupItems()
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        gori2Lunar.state = NSControl.StateValue(rawValue: 1)
        lunar2Gori.state = NSControl.StateValue(rawValue: 0)
        goriDetail.alignment = .center
        addPopUpItem()
    }
    
}
