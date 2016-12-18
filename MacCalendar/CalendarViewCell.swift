//
//  CalendarViewCell.swift
//  StatebarCalendar
//
//  Created by bugcode on 2016/12/18.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Cocoa

class CalendarViewCell: NSButtonCell {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawTitle(_ title: NSAttributedString, withFrame frame: NSRect, in controlView: NSView) -> NSRect {
        if !self.isEnabled {
            return super.drawTitle(self.attributedTitle, withFrame: frame, in: controlView)
        }
        return super.drawTitle(title, withFrame: frame, in: controlView)
    }
}

