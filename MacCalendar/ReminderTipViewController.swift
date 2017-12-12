//
//  ReminderTipWindowController.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/10.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Cocoa

class ReminderTipViewController : NSViewController {
    
    @IBOutlet var mainView: NSView!

    @IBOutlet weak var tipsInfo: NSTextField!
    @IBOutlet weak var addReminderBtn: NSButton!
    
    var mCurDate: CalendarUtils.WZDayTime?
    var mCalView: CalendarCellView?
    
    @IBAction func competeHandler(_ sender: NSButton) {
        Swift.print("content = \(tipsInfo.stringValue)")
        let dateStr = String(describing: mCurDate!.year) + String(describing: mCurDate!.month) + String(describing: mCurDate!.day)
        Swift.print("completeHandler dateStr = \(dateStr)")
        LocalDataManager.sharedInstance.saveData(data: tipsInfo.stringValue, forKey: dateStr)
        mCalView?.performPopoverClose()
    }
    // 加载view
    override func loadView() {
        var tlp : NSArray = NSArray()
        if Bundle.main.loadNibNamed("ReminderTipViewController", owner: self, topLevelObjects: &tlp) {
            mainView = tlp.first(where: { $0 is NSView }) as? NSView
        }
    }
    
    init(date: CalendarUtils.WZDayTime, view: CalendarCellView) {
        super.init(nibName: "ReminderTipViewController", bundle: nil)!
        mCurDate = date
        mCalView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
