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
    
    var bgColor = NSColor.whiteColor()
    var generalDateColor = NSColor.grayColor()
    var holidayDateColor = NSColor.redColor()
    var selectedDateColor = NSColor.greenColor()
    var todayDateColor = NSColor.yellowColor()
    
    
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