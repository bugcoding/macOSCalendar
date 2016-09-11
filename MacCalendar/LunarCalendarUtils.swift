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
        
        // 最近一个冬至
        let lastDongZhi = CalendarUtils.sharedInstance.jdLocalTimetoTD(localJD: mSolarTermsJD[0])
        // 与冬至最近的一个朔日
        var tmpShuo = CalendarUtils.sharedInstance.calculateMoonShuoJD(tdJD: lastDongZhi)
        tmpShuo = CalendarUtils.sharedInstance.jdTDtoLocalTime(tdJD: tmpShuo)
        
        if tmpShuo > mSolarTermsJD[0] {
            tmpShuo -= 29.53
        }
        
        getNewMoonJDs(jd: tmpShuo, newMoon: &mNewMoonJD)
    }
    
    func getNewMoonJDs(jd: Double, newMoon: inout [Double]) {
        var tdJD = CalendarUtils.sharedInstance.jdLocalTimetoTD(localJD: jd)
        for i in 0 ..< CalendarConstant.NEW_MOON_CALC_COUNT {
            var shuoJD = CalendarUtils.sharedInstance.calculateMoonShuoJD(tdJD: tdJD)
            shuoJD = CalendarUtils.sharedInstance.jdTDtoLocalTime(tdJD: shuoJD)
            newMoon[i] = shuoJD
            
            tdJD += 29.5
        }
    }
    
    func getAllSolarTermsJD(year: Int, start: Int, solarTerms: inout [Double]) {
        var i = 0
        var st = start
        var y = year
        while i < 25 {
            let jd = CalendarUtils.sharedInstance.calculateSolarTerms(year: y, angle: st * 15)
            solarTerms[i] = CalendarUtils.sharedInstance.jdTDtoLocalTime(tdJD: jd)
            i += 1
            if st == CalendarConstant.WINTER_SOLSTICE {
                y += 1
            }
            st = (st + 1) % CalendarConstant.SOLAR_TERMS_COUNT
        }
    }
    
    func buildAllChnMonthInfo() -> Bool {
        var info: CHN_MONTH_INFO = CHN_MONTH_INFO()
        var yueJian = 11
        
        for i in 0 ..< CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
            info.mmonth = i
            info.mname = (yueJian <= 12) ? yueJian : yueJian - 12
            info.shuoJD = mNewMoonJD[i]
            info.nextJD = mNewMoonJD[i + 1]
            info.mdays = Int(info.nextJD + 0.5) - Int(info.shuoJD + 0.5)
            info.leap = 0
            
            let cm = ChnMonthInfo(m: info)
            mChnMonthInfo.append(cm)
            
            yueJian += 1
        }
        
        return (mChnMonthInfo.count == CalendarConstant.NEW_MOON_CALC_COUNT - 1)
    }
    
    func calcLeapChnMonth() {
        assert(mChnMonthInfo.count > 0)
        
        if Int(mNewMoonJD[13] + 0.5) <= Int(mSolarTermsJD[24] + 0.5) {
            var i = 0
            while i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                if Int(mNewMoonJD[i + 1] + 0.5) <= Int(mSolarTermsJD[2 * i] + 0.5) {
                    break
                }
                i += 1
            }
            if i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                mChnMonthInfo[i].setLeapMonth(leap: true)
                while i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                    mChnMonthInfo[i] .reIndexMonthName()
                }
            }
        }
    }
    
    
    func setGeriYear(year: Int) -> Bool {
        
        clearCalendar()
        mYear = year
        
        calcProcData()
        
        if !buildAllChnMonthInfo() {
            return false
        }
        
        
        return mInit
    }
    
    
    
    
    
    
    
    
    
    
    
}
