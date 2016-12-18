//
//  GeneralButton.swift
//  StatebarCalendar
//
//  Created by bugcode on 2016/12/18.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

// 普通按钮的扁平处理
class GeneralButton : NSButton{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isBordered = false
        self.wantsLayer = true
        self.layer!.backgroundColor = NSColor.white.cgColor
    }
    
}
