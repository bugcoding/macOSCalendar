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
    var mContent:String = ""
    
    @IBAction func competeHandler(_ sender: NSButton) {
        Swift.print("content = \(tipsInfo.stringValue)")
        let dateStr = String(describing: mCurDate!.year) + String(describing: mCurDate!.month) + String(describing: mCurDate!.day)
        LocalDataManager.sharedInstance.saveData(data: tipsInfo.stringValue, forKey: dateStr)
        // 同步更新tooltips
        mCalView?.toolTip = tipsInfo.stringValue
        mCalView?.performPopoverClose()
    }
    // 加载view
    override func loadView() {
        var tlp : NSArray = NSArray()
        if Bundle.main.loadNibNamed("ReminderTipViewController", owner: self, topLevelObjects: &tlp) {
            mainView = tlp.first(where: { $0 is NSView }) as? NSView
        }
    }
    
    // 把原有标记显示在编辑框中
    override func viewDidLoad() {
        tipsInfo.stringValue = mContent
        // 完成按钮响应回车
        addReminderBtn.keyEquivalent = "\r"
    }
    init(date: CalendarUtils.WZDayTime, view: CalendarCellView, content: String) {
        super.init(nibName: "ReminderTipViewController", bundle: nil)!
        mCurDate = date
        mCalView = view
        mContent = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
