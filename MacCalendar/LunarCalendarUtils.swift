//
//  ChineseCalendarUtils.swift
//  MacCalendar
//
//  Created by bugcode on 16/9/8.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Foundation

class LunarCalendarUtils {
//    // 单例
//    class var sharedInstance : LunarCalendarUtils{
//        
//        struct Static{
//            static let ins:LunarCalendarUtils = LunarCalendarUtils()
//        }
//        return Static.ins
//    }
    init(){
        
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
        mInit = false
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
        print("getNewMoonJDS end")
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
        
        var i = 0
        if Int(mNewMoonJD[13] + 0.5) <= Int(mSolarTermsJD[24] + 0.5) {
            i = 1
            while i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                if Int(mNewMoonJD[i + 1] + 0.5) <= Int(mSolarTermsJD[2 * i] + 0.5) {
                    break
                }
                i += 1
            }
            if i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                mChnMonthInfo[i].setLeapMonth(leap: true)
                while i < CalendarConstant.NEW_MOON_CALC_COUNT - 1 {
                    mChnMonthInfo[i].reIndexMonthName()
                    i += 1
                }
            }
        }
    }
    func findChnMonthInfo(todayJD: Double) -> ChnMonthInfo {
        assert(mChnMonthInfo.count > 0)
        let thisDay = Int(todayJD + 0.5)
        
        var i = 0
        while i < mChnMonthInfo.count {
            let lastDay = Int(mChnMonthInfo[i].mInfo.shuoJD + 0.5)
            let nextDay = Int(mChnMonthInfo[i].mInfo.nextJD + 0.5)
            if thisDay >= lastDay && thisDay < nextDay {
                return mChnMonthInfo[i]
            }
            i += 1
        }
        
        return mChnMonthInfo[0]
    }
    
    func getSolarTermsName(solarTerms: [Double], count: Int, today: Double) -> CalendarConstant.SOLAR_TERMS {
        var i = 0
        while i < 25 {
            if Int(solarTerms[i] + 0.5) == Int(today + 0.5) {
                return (i + 18) % CalendarConstant.SOLAR_TERMS_COUNT
            }
            i += 1
        }
        return -1
    }
    
    func buildMonthAllDaysInfo(mi: inout MonthInfo) -> Bool {
        var info: DAY_INFO = DAY_INFO()
        for i in 0 ..< mi.mInfo.days {
            let today = CalendarUtils.sharedInstance.calcJulianDay(mYear, month: mi.mInfo.month, day: i + 1, hour: 0, min: 0, second: 1)
            info.dayNo = i + 1
            info.week = (mi.mInfo.weekOf1stDay + i) % CalendarConstant.DAYS_FOR_WEEK
            let cm = findChnMonthInfo(todayJD: today)
            info.mmonth = cm.mInfo.mmonth
            info.mdayNo = Int(today + 0.5) - Int(cm.mInfo.shuoJD + 0.5)
            info.st = getSolarTermsName(solarTerms: mSolarTermsJD, count: 25, today: today)
            
            let di = DayInfo(info: info)
            mi.addSingleDay(dayInfo: di)
        }
        return mi.checkValidDayCount()
    }
    
    func buildMonthInfo(month: Int) -> Bool {
        var info: MONTH_INFO = MONTH_INFO()
        info.month = month
        info.weekOf1stDay = CalendarUtils.sharedInstance.getWeekDayBy(mYear, month: month, day: 1)
        info.days = CalendarUtils.sharedInstance.getDaysOfMonthBy(mYear, month: info.month)
        var mi = MonthInfo(info: info)
        
        if buildMonthAllDaysInfo(mi: &mi) {
            mMonthInfo.append(mi)
            return true
        }
        return false
    }
    
    func buildAllMonthInfo() -> Bool {
        assert(mChnMonthInfo.count > 0)
        
        for i in 0 ..< CalendarConstant.MONTHES_FOR_YEAR {
            if !buildMonthInfo(month: i + 1) {
                return false
            }
        }
        return true
    }
    
    func setGeriYear(year: Int) -> Bool {
        
        clearCalendar()
        mYear = year
        
        calcProcData()
        
        if !buildAllChnMonthInfo() {
            return false
        }
        calcLeapChnMonth()
        mInit = buildAllMonthInfo()
        
        return mInit
    }
    
    
    func getSpringBeginDay(month: inout Int, day: inout Int) {
        if !mInit {
            return
        }

        var dt: CalendarUtils.WZDayTime = CalendarUtils.WZDayTime()
        CalendarUtils.sharedInstance.getDayTimeFromJulianDay(mSolarTermsJD[CalendarConstant.SPRING_BEGINS_INDEX], dt: &dt)
        
        month = dt.month
        day = dt.day
    }
    
    func isCalendarReady() -> Bool {
        return mInit
    }
    
    func getCurrentYear() -> Int {
        return mYear
    }
    
    func getMonthInfo(month: Int) -> MonthInfo {
        assert(mMonthInfo.count == CalendarConstant.MONTHES_FOR_YEAR)
        
        if month < 1 || month > CalendarConstant.MONTHES_FOR_YEAR {
            return mMonthInfo[0]
        }
        return mMonthInfo[month - 1]
    }
    
    func getChnMonthInfo(month: Int) -> ChnMonthInfo {
        assert(mChnMonthInfo.count > 0)
        
        if month < 0 || month > mChnMonthInfo.count {
            return mChnMonthInfo[0]
        }
        return mChnMonthInfo[month]
    }
    
    
    
}
