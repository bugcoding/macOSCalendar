//
//  ChineseCalendarUtils.swift
//  MacCalendar
//
//  Created by bugcode on 16/9/8.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Foundation

class LunarCalendarUtils {
    // 单例
    class var sharedInstance : LunarCalendarUtils{
        
        struct Static{
            static let ins:LunarCalendarUtils = LunarCalendarUtils()
        }
        return Static.ins
    }
    fileprivate init(){
        
    }
    
    private var mInit:Bool = false
    private var mYear:Int = 0
    
    private var mSolarTermsJD = Array(repeating: 0.0, count: CalendarConstant.SOLAR_TERMS_CALC_COUNT)
    private var mNewMoonJD = Array(repeating: 0.0, count: CalendarConstant.NEW_MOON_CALC_COUNT)
    
    private var mMonthInfo = [MonthInfo]()
    private var mChnMonthInfo = [ChnMonthInfo]()

    
    
    
    
}
