//
//  IconView.swift
//  MacCalendar
//
//  Created by bugcode on 2016/9/21.
//  Copyright © 2016年 bugcode. All rights reserved.
//


import Foundation
import Cocoa

class IconView : NSView
{
    private(set) var image: NSImage
    private let item: NSStatusItem
    
    var onMouseDown: () -> ()
    
    var isSelected: Bool {
        didSet
        {
            //redraw if isSelected changes for bg highlight
            if (isSelected != oldValue)
            {
                self.needsDisplay = true
            }
        }
    }
    
    init(imageName: String, item: NSStatusItem) {
        self.image = NSImage(named: imageName)!
        self.item = item
        self.isSelected = false
        self.onMouseDown = {}
        
        let thickness = NSStatusBar.system().thickness
        let rect = CGRect(x: 0, y: 0, width: thickness, height: thickness)
        
        super.init(frame: rect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        self.item.drawStatusBarBackground(in: dirtyRect, withHighlight: self.isSelected)
        
        let size = self.image.size
        let rect = CGRect(x: 2, y: 2, width: size.width, height: size.height)
        
        self.image.draw(in: rect)
    }
    
    override func mouseDown(with event: NSEvent) {
        
        self.isSelected = !self.isSelected;
        self.onMouseDown();
    }
    
    override func mouseUp(with event: NSEvent) {
    }
}
