//
//  CalendarDataStruct.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/23.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Foundation

struct DAY_INFO {
    // 当月公历日
    var dayNo:Int
    // 当日星期
    var week:Int
    // 当月农历日
    var mdayNo:Int
    // 当日所在的农历月
    var mmonth:Int
    // 当日的节气，-1对应无节气
    var st:CalendarConstant.SOLAR_TERMS

}

struct MONTH_INFO {
    // 当前的公历月份
    var month:Int
    // 当前的月份的天数
    var days:Int
    // 本月1号是星期几
    var weekOf1stDay:Int
    // 本月节气儒略，本地时间
    var jieqiJD:Int
    // 本月节气序号
    var jieqi:CalendarConstant.SOLAR_TERMS
    // 本月中气儒略，本地时间
    var zhongqiJD:Double
    //中气序号
    var zhongqi:CalendarConstant.SOLAR_TERMS
}

struct CHN_MONTH_INFO {
    // 当前农历月
    var mmonth:Int
    // 农历月名
    var mname:Int
    // 本月有几天
    var mdays:Int
    //本月朔日的儒略日
    var shuoJD:Double
    // 下月朔月的儒略日
    var nextJD:Double
    // 1 闫月 0 正常月
    var leap:Int
}

// 月日年 数据结构，内容移植自<算法的乐趣 -- 王晓华> 示例代码
class DayInfo {

    init(info:DAY_INFO){
        mInfo = info
    }
    
    // 当日的数据
    var mInfo:DAY_INFO {
        get{
            return self.mInfo
        }
        set{
            self.mInfo = newValue
        }
    }
}

class MonthInfo {

    
    init(info:MONTH_INFO){
        mInfo = info
    }
    
    private var mDayInfo = [DAY_INFO]()

    func getDayInfo(day: Int) -> DAY_INFO {
        if (day < 1) || day > mDayInfo.count {
            return mDayInfo[0]
        }
        return mDayInfo[day - 1]
    }
    func addSingleDay(dayInfo: DAY_INFO) {
        mDayInfo.append(dayInfo)
    }
    func checkValidDayCount() -> Bool {
        return mInfo.days == mDayInfo.count
    }
    func clearInfo() {
        mDayInfo.removeAll()
    }
    
    
    var mInfo:MONTH_INFO {
        get{
            return self.mInfo
        }
        set{
            self.mInfo = newValue
        }
    }
}

class ChnMonthInfo {
    
    func setLeapMonth(leap: Bool) {
        mInfo.leap = leap ? 1 : 0
    }
    
    func reIndexMonthName() {
        mInfo.mname -= 1
    }
    
    func isLeapMonth() -> Bool {
        return mInfo.leap == 1
    }
    
    
    var mInfo:CHN_MONTH_INFO {
        get{
            return self.mInfo
        }
        set{
            self.mInfo = newValue
        }
    }
}













