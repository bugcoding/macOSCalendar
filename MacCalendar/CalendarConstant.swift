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
    
    //
    static let NEW_MOON_CALC_COUNT = 15
    // 春节开始
    static let SPRING_BEGINS_INDEX = 3
    // 节气数
    static let SOLAR_TERMS_CALC_COUNT = 25
    // 格里历启用年份
    static let GREGORIAN_CALENDAR_OPEN_YEAR = 1582
    // 格里历启用月份
    static let GREGORIAN_CALENDAR_OPEN_MONTH = 10
    // 格里历启用日期
    static let GREGORIAN_CALENDAR_OPEN_DAY = 15
    
    // 闫年
    static let DAYS_OF_MONTH_LEAP_YEAR = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    // 平年
    static let DAYS_OF_MONTH_NORMAL_YEAR = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    // 星期汉字
    static let WEEK_NAME_OF_CHINESE = ["日", "一", "二", "三", "四", "五", "六"]
    
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
    
    
    // moved from <算法的乐趣 - 王晓华> 示例代码nutation.cpp
    // 计算天体章动系数类型
    struct NUTATION_COEFFICIENT {
        var D:Double
        var M:Double
        var Mp:Double
        var F:Double
        var omega:Double
        var sine1:Double
        var sine2:Double
        var cosine1:Double
        var cosine2:Double
        init(_ d:Double, _ m:Double, _ mp:Double, _ f:Double, _ mga:Double, _ sin1:Double, _ sin2:Double, _ cos1:Double, _ cos2:Double){
            D = d
            M = m
            Mp = mp
            F = f
            omega = mga
            sine1 = sin1
            sine2 = sin2
            cosine1 = cos1
            cosine2 = cos2
        }
    }
    
    
    /*
     天体黄经章动和黄赤交角章动的周期项，来源《天体计算》第21章，表21-A
     单位是0".0001.
     */
    static let nutation:[NUTATION_COEFFICIENT] = [
        NUTATION_COEFFICIENT( 0, 0, 0, 0, 1, -171996,  -174.2,  92025,     8.9    ),
        NUTATION_COEFFICIENT(-2, 0, 0, 2, 2,  -13187,    -1.6,   5736,    -3.1    ),
        NUTATION_COEFFICIENT( 0, 0, 0, 2, 2,   -2274,    -0.2,    977,    -0.5    ),
        NUTATION_COEFFICIENT( 0, 0, 0, 0, 2,    2062,     0.2,   -895,     0.5    ),
        NUTATION_COEFFICIENT( 0, 1, 0, 0, 0,    1426,    -3.4,     54,    -0.1    ),
        NUTATION_COEFFICIENT( 0, 0, 1, 0, 0,     712,     0.1,     -7,       0    ),
        NUTATION_COEFFICIENT(-2, 1, 0, 2, 2,    -517,     1.2,    224,    -0.6    ),
        NUTATION_COEFFICIENT( 0, 0, 0, 2, 1,    -386,    -0.4,    200,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 1, 2, 2,    -301,       0,    129,    -0.1    ),
        NUTATION_COEFFICIENT(-2,-1, 0, 2, 2,     217,    -0.5,    -95,     0.3    ),
        NUTATION_COEFFICIENT(-2, 0, 1, 0, 0,    -158,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 0, 2, 1,     129,     0.1,    -70,       0    ),
        NUTATION_COEFFICIENT( 0, 0,-1, 2, 2,     123,       0,    -53,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 0, 0, 0,      63,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 1, 0, 1,      63,     0.1,    -33,       0    ),
        NUTATION_COEFFICIENT( 2, 0,-1, 2, 2,     -59,       0,     26,       0    ),
        NUTATION_COEFFICIENT( 0, 0,-1, 0, 1,     -58,    -0.1,     32,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 1, 2, 1,     -51,       0,     27,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 2, 0, 0,      48,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0,-2, 2, 1,      46,       0,    -24,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 0, 2, 2,     -38,       0,     16,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 2, 2, 2,     -31,       0,     13,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 2, 0, 0,      29,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 1, 2, 2,      29,       0,    -12,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 0, 2, 0,      26,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 0, 2, 0,     -22,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0,-1, 2, 1,      21,       0,    -10,       0    ),
        NUTATION_COEFFICIENT( 0, 2, 0, 0, 0,      17,    -0.1,      0,       0    ),
        NUTATION_COEFFICIENT( 2, 0,-1, 0, 1,      16,       0,     -8,       0    ),
        NUTATION_COEFFICIENT(-2, 2, 0, 2, 2,     -16,     0.1,      7,       0    ),
        NUTATION_COEFFICIENT( 0, 1, 0, 0, 1,     -15,       0,      9,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 1, 0, 1,     -13,       0,      7,       0    ),
        NUTATION_COEFFICIENT( 0,-1, 0, 0, 1,     -12,       0,      6,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 2,-2, 0,      11,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 2, 0,-1, 2, 1,     -10,       0,      5,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 1, 2, 2,      -8,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 0, 1, 0, 2, 2,       7,       0,     -3,       0    ),
        NUTATION_COEFFICIENT(-2, 1, 1, 0, 0,      -7,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0,-1, 0, 2, 2,      -7,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 0, 2, 1,      -7,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 1, 0, 0,       6,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 2, 2, 2,       6,       0,     -3,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 1, 2, 1,       6,       0,     -3,       0    ),
        NUTATION_COEFFICIENT( 2, 0,-2, 0, 1,      -6,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 2, 0, 0, 0, 1,      -6,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 0,-1, 1, 0, 0,       5,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2,-1, 0, 2, 1,      -5,       0,      3,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 0, 0, 1,      -5,       0,      3,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 2, 2, 1,      -5,       0,      3,       0    ),
        NUTATION_COEFFICIENT(-2, 0, 2, 0, 1,       4,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 1, 0, 2, 1,       4,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 1,-2, 0,       4,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-1, 0, 1, 0, 0,      -4,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-2, 1, 0, 0, 0,      -4,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 1, 0, 0, 0, 0,      -4,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 1, 2, 0,       3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0,-2, 2, 2,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT(-1,-1, 1, 0, 0,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 1, 1, 0, 0,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0,-1, 1, 2, 2,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 2,-1,-1, 2, 2,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 0, 0, 3, 2, 2,      -3,       0,      0,       0    ),
        NUTATION_COEFFICIENT( 2,-1, 0, 2, 2,      -3,       0,      0,       0    )
    ]
    
    static let stAccInfo:[Double] = [
        0.00, 1272494.40, 2548020.60, 3830143.80, 5120226.60, 6420865.80,
        7732018.80, 9055272.60, 10388958.00, 11733065.40, 13084292.40, 14441592.00,
        15800560.80, 17159347.20, 18513766.20, 19862002.20, 21201005.40, 22529659.80,
        23846845.20, 25152606.00, 26447687.40, 27733451.40, 29011921.20, 30285477.60
    ]
    
    //已知1900年小寒时刻为1月6日2:05:00，
    static let base1900SlightColdJD = 2415025.5868055555;
    
   

    
    
    
    
    
    
    
    
    
    
}
