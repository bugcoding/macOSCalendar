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
        selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: -1)
    }
    
    @IBAction func rightArrowBtnHandler(sender:AnyObject){
        selectDataText.stringValue = CalendarUtils.sharedInstance.getMonthDateStringBy(selectDataText.stringValue, step: 1)
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
