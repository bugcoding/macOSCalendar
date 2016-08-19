//
//  CalendarConstant.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/18.
//  // 本文件内容部分来自<算法的乐趣>书中示例代码，源码为c++，如有不妥请告知。
//

import Foundation

/*
 
 计算日历相关的各种常量
 
 */

class CalendarConstant{
    

    
    
    
    
    // 闫年
    static let DAYS_OF_MONTH_LEAP_YEAR = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    // 平年
    static let DAYS_OF_MONTH_NORMAL_YEAR = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    // 农历天干地支
    static let HEAVENLY_STEMS_NAME = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    static let EARTHY_BRANCHES_NAME = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    // 中国生肖
    static let CHINESE_ZODIC_NAME = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    
    // 每年月数
    static let MONTHES_FOR_YEAR = 12
    // 每星期天数
    static let DAYS_FOR_WEEK = 7
    // 闰年天数
    static let DAYS_OF_LEAP_YEAR = 366
    // 平年天数
    static let DAYS_OF_NORMAL_YEAR = 365
    // 节气数
    static let SOLAR_TERMS_COUNT = 24
    // 天干
    static let HEAVENLY_STEMS = 10
    // 地支
    static let EARTHLY_BRANCHES = 12
    // 生肖
    static let CHINESE_SHENGXIAO = 12
    // 公历月最大天数
    static let MAX_GREGORIAN_MONTH_DAYS = 31
    // 农历月最大天数
    static let MAX_CHINESE_MONTH_DAYS = 30
    // 农历大月
    static let CHINESE_L_MONTH_DAYS = 30
    // 农历小月
    static let CHINESE_S_MONTH_DAYS = 29
    // 农历每年最多月数(闫月)
    static let MAX_CHINESE_MONTH_FOR_YEAR = 13
    
    static let JD2000 = 2451545.0
    // 圆周率
    static let PI = 3.1415926535897932384626433832795
    
    // 每弧度的角秒数
    static let ARC_SEC_PER_RADIAN = 180.0 * 3600.0 / PI
    // 一度代表的弧度
    static let RADIAN_PER_ANGLE = PI / 180.0
    
    static let SUN_EL_V = 360.0 / 365.2422
    //const double MOON_EL_V = 360.0 / 29.53058886
    static let MOON_EL_V = 360.0 / 27.32
    
    typealias SOLAR_TERMS = Int
    
    // 24 节气
    static let VERNAL_EQUINOX      = 0    // 春分
    static let CLEAR_AND_BRIGHT    = 1    // 清明
    static let GRAIN_RAIN          = 2    // 谷雨
    static let SUMMER_BEGINS       = 3    // 立夏
    static let GRAIN_BUDS          = 4    // 小满
    static let GRAIN_IN_EAR        = 5    // 芒种
    static let SUMMER_SOLSTICE     = 6    // 夏至
    static let SLIGHT_HEAT         = 7    // 小暑
    static let GREAT_HEAT          = 8    // 大暑
    static let AUTUMN_BEGINS       = 9    // 立秋
    static let STOPPING_THE_HEAT   = 10   // 处暑
    static let WHITE_DEWS          = 11   // 白露
    static let AUTUMN_EQUINOX      = 12   // 秋分
    static let COLD_DEWS           = 13   // 寒露
    static let HOAR_FROST_FALLS    = 14   // 霜降
    static let WINTER_BEGINS       = 15   // 立冬
    static let LIGHT_SNOW          = 16   // 小雪
    static let HEAVY_SNOW          = 17   // 大雪
    static let WINTER_SOLSTICE     = 18   // 冬至
    static let SLIGHT_COLD         = 19   // 小寒
    static let GREAT_COLD          = 20   // 大寒
    static let SPRING_BEGINS       = 21   // 立春
    static let THE_RAINS           = 22   // 雨水
    static let INSECTS_AWAKEN      = 23   // 惊蛰
    
    
    // 农历日显示名称
    static let nameOfChnDay:[String] = [
        "初一","初二","初三","初四","初五","初六","初七","初八","初九","初十",
        "十一","十二","十三","十四","十五","十六","十七","十八","十九","二十",
        "廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"
    ]
    // 农历月份名称
    static let nameOfChnMonth:[String] = ["正","二","三","四","五","六","七","八","九","十","十一","腊"]
    
    // 节气名称
    static let nameOfJieQi:[String] = [
        "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑",
        "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬",
        "小雪", "大雪", "冬至", "小寒", "大寒", "立春", "雨水", "惊蛰"
    ]
    
}