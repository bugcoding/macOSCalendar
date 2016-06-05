//
//  CalendarPanel.swift
//  SwiftCalendar
//
//  Created by bugcode on 16/6/5.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Foundation
import Cocoa

class CalendarPanel:NSViewController{
    
    // MARK: Oulets
    @IBOutlet var selectedDataText: NSTextField!
    @IBOutlet var rightArrowBtn: NSButton!
    @IBOutlet var leftArrowBtn: NSButton!
    
    // MARK: self define var
    var bgColor = NSColor.whiteColor()
    var generalDateColor = NSColor.grayColor()
    var holidayDateColor = NSColor.redColor()
    var selectedDateColor = NSColor.greenColor()
    var todayDateColor = NSColor.yellowColor()
    
    
    // MARK: functions define
    init(){
        super.init(nibName: "CalendarPanel", bundle: nil)!
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // init some self view components
    func viewInit(){
        
    }
    
    
}