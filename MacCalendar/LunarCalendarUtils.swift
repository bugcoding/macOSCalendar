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
    
    func clearCalendar() {
        for (_, monthInfo) in mMonthInfo.enumerated() {
            monthInfo.clearInfo()
        }
        mMonthInfo.removeAll()
        mChnMonthInfo.removeAll()
        
        mSolarTermsJD = mSolarTermsJD.flatMap{$0 * 0.0}
        mNewMoonJD = mNewMoonJD.flatMap{$0 * 0.0}
    }
    
    func calcProcData() {
        //计算从上一年冬至开始到今天冬至全部25个节气
        getAllSolarTermsJD(year: mYear - 1, start: CalendarConstant.WINTER_SOLSTICE, solarTerms: &mSolarTermsJD)
    }
    
    func getAllSolarTermsJD(year: Int, start: Int, solarTerms: inout [Double]) {
        var i = 0
        var st = start
        var y = year
        while i < 25 {
            let jd = CalendarUtils.sharedInstance.calculateSolarTerms(year: y, angle: st * 15)
            solarTerms[i] = CalendarUtils.sharedInstance.jdTDtoLocalTime(tdJD: jd)
            if st == CalendarConstant.WINTER_SOLSTICE {
                y += 1
            }
            st = (st + 1) % CalendarConstant.SOLAR_TERMS_COUNT
        }
    }
    
    func setGeriYear(year: Int) -> Bool {
        
        clearCalendar()
        mYear = year
        
        calcProcData()
        
        return mInit
    }
    
    
    
    
    
    
    
    
    
    
    
}
