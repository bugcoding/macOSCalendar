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
    @IBOutlet weak var selectDataText:NSTextField!
    @IBOutlet weak var leftArrowBtn:NSButton!
    @IBOutlet weak var rightArrowBtn:NSButton!
    
    var cellBtns = [CalendarCellView!]()
    
    // windowNibName override
    override var windowNibName: String?{
        return "CalendarViewController"
    }
    
    // MARK: Button handler
    @IBAction func leftArrowBtnHandler(sender:AnyObject){
        selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: -1)
        showDaysInFormsBy(selectDataText.stringValue)
    }
    
    @IBAction func rightArrowBtnHandler(sender:AnyObject){
        selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: 1)
        showDaysInFormsBy(selectDataText.stringValue)
    }
    
    // default display setting
    func showDefaultDate() {
        let utils = CalendarUtils.sharedInstance
        // set current date to textfield after window launched
        selectDataText.stringValue = utils.getDateStringOfToday()
        showDaysInFormsBy(utils.getDateStringOfToday())
    }
    
    // show date
    func showDaysInFormsBy(dateString: String){
        // get week day of month fisrt day
        let utils = CalendarUtils.sharedInstance
        
        let monthDays = utils.getDaysBy(dateString)
        
        let weekDayOf1stDay = utils.getWeekBy(dateString, andFirstDay: 1)
        let weekDayOfLastDay = utils.getWeekBy(dateString, andFirstDay: monthDays)
        
        print("dateString = \(dateString) weekOf1stDay = \(weekDayOf1stDay) weekOfLastDay = \(weekDayOfLastDay) monthDays = \(monthDays) ")
        
        for (index, btn) in cellBtns.enumerate() {
            
            print("showDaysInFormsBy index = \(index)")
            btn.enabled = true
            if index < weekDayOf1stDay || index >= monthDays + weekDayOf1stDay {
                btn.enabled = false
                btn.title = ""
            
            } else {
                // get current cell's row number
                let curCellRow = Int((btn.cellID - 1) / 7) + 1
                print("currentRowNumber = \(curCellRow) btn.intValue = \(btn.intValue)")
                
                
                btn.title = "\(index - weekDayOf1stDay + 1)"
                
                // handle weekend title font color
                if index % 7 == 1 || index % 7 == 0 {
                    // mark SAT and SUN
                    // TODO:
                }
            }

        }
    }
    
    
    
    // get button by identifier
    func getButtonByIdentifier(id:String) -> NSView? {
        for subView in (self.window?.contentView?.subviews[0].subviews)! {
            if subView.identifier == id {
                return subView
            }
        }
        return nil
    }
    // button press handler
    func dateButtonHandler(sender:NSButton){
        print("Press Button is \(sender.identifier)")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // load all buttons
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
        
        for (index, btn) in cellBtns.enumerate() {
            print("cellbtns index = \(index) btn.action = \(btn.action) btn.intValue = \(btn.cellID)")
        }
        
        // default setting for display
        self.showDefaultDate()
        
    }
    
}
