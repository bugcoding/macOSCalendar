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
    
    // windowNibName override
    override var windowNibName: String?{
        return "CalendarViewController"
    }
    
    // MARK: Button handler
    @IBAction func leftArrowBtnHandler(sender:AnyObject){
        selectDataText.stringValue = self.getMonthDateStringBy(-1)
    }
    
    @IBAction func rightArrowBtnHandler(sender:AnyObject){        

        selectDataText.stringValue = self.getMonthDateStringBy(1)
    }
    
    // get next month dateString
    func getMonthDateStringBy(step:Int)->String {
        let date = CalendarUtils.sharedInstance.getYMDTuppleBy(selectDataText.stringValue)
        
        var year = date.year
        var curMonth = date.month
        curMonth = curMonth + step
        if curMonth > 12 && step > 0 {
            curMonth = 1
            year = year + 1
        }
        else if curMonth < 1 && step < 0{
            curMonth = 12
            year = year - 1
        }
        
        // construct next month date format string
        let monthDateString = String(year) + "-" + String(curMonth) + "-" + String(date.day)
        return monthDateString
    }
    
    
    // default display setting
    func showDefaultDate() {
        let utils = CalendarUtils.sharedInstance
        // set current date to textfield after window launched
        selectDataText.stringValue = utils.getDateStringOfToday()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // default setting for display
        self.showDefaultDate()
    }
    
}
