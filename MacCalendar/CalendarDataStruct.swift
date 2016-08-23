//
//  CalendarDataStruct.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/23.
//  Copyright © 2016年 bugcode. All rights reserved.
//

import Foundation


// 月日年 数据结构，内容移植自<算法的乐趣 -- 王晓华> 示例代码
class DayInfo {
    struct stDayInfo {
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
    typealias DAY_INFO = stDayInfo
    
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
