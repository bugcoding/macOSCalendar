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
        selectDataText.stringValue = "LeftButton Clicked"
        print(CalendarUtils.sharedInstance.getDateStringOfToday())
    }
    
    @IBAction func rightArrowBtnHandler(sender:AnyObject){
        selectDataText.stringValue = "RightButton Clicked"
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // set current date to textfield after window launched
        selectDataText.stringValue = CalendarUtils.sharedInstance.getDateStringOfToday()
    }
    
}
