/*====================
 
 FileName    : CalendarUtils
 Desc        : Utils Function For Calendar (singleton class)
 Author      : bugcode
 Email       : bugcoding@gmail.com
 CreateDate  : 2016-5-8
 
 ====================*/

import Foundation

open class CalendarUtils{
    
    // 单例
    class var sharedInstance : CalendarUtils{
        
        struct Static{
            static let ins:CalendarUtils = CalendarUtils()
        }
        return Static.ins
    }
    fileprivate init(){
        
    }
    
    // 每天的时间结构
    struct WZDayTime{
        // 年月日时分秒
        var year:Int
        var month:Int
        var day:Int
        var hour:Int
        var minute:Int
        var second:Double
    }
    
    
    // 蔡勒公式算公历某天的星期
    func getWeekDayBy(_ year:Int, month m:Int, day d:Int) -> Int {
        var year = year
        var m = m
        if m < 3 {
            year -= 1
            m += 12
        }
        
        // 年份的最后二位. 2003 -> 03 | 1997 -> 97
        let y:Int = year % 100
        // 年份的前二位. 2003 -> 20 | 1997 -> 19
        let c:Int = Int(year / 100)
        
        var week:Int = Int(c / 4) - 2 * c + y + Int(y / 4) + (26 * (m + 1) / 10) + d - 1

        week = (week % 7 + 7) % 7
        
        return week
    }
    
    // 通过2000年有基准获取某一农历年的干支
    func getLunarYearNameBy(_ year:Int) -> (heaven:String, earthy:String, zodiac:String){
        let baseMinus:Int = year - 2000
        
        var heavenly = (7 + baseMinus) % 10
        var earth = (5 + baseMinus) % 12
        
        if heavenly <= 0 {
            heavenly += 10
        }
        if earth <= 0 {
            earth += 12
        }
        
        return (CalendarConstant.HEAVENLY_STEMS_NAME[heavenly - 1], CalendarConstant.EARTHY_BRANCHES_NAME[earth - 1], CalendarConstant.CHINESE_ZODIC_NAME[earth - 1])
    }
    
    // 平，闫年判定
    func getIsLeapBy(_ year:Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    }
    
    // 指定月份的天数
    func getDaysBy(_ dateString: String) -> Int {
        let (year, m, _) = getYMDTuppleBy(dateString)
        var days = 0
        if getIsLeapBy(year) {
            days = CalendarConstant.DAYS_OF_MONTH_LEAP_YEAR[m]
        }
        else{
            days = CalendarConstant.DAYS_OF_MONTH_NORMAL_YEAR[m]
        }
        return days
    }
    
    // 今天的日期
    func getDateStringOfToday() -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: nowDate)
        return dateString
    }
    
    // 根据日期字符串 yyyy-mm-dd形式获取(year,month,day)的元组
    func getYMDTuppleBy(_ dateString:String) -> (year:Int, month:Int, day:Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString)
        
        formatter.dateFormat = "yyyy"
        let y = formatter.string(from: date!)
        
        formatter.dateFormat = "MM"
        let m = formatter.string(from: date!)
        
        formatter.dateFormat = "dd"
        let d = formatter.string(from: date!)
        
        return (Int(y)!, Int(m)!, Int(d)!)
    }
    
    // 根据传入日期字符串获取下月
    func getMonthDateStringBy(_ dateString:String, step:Int)->String {
        let date = getYMDTuppleBy(dateString)
        
        var year = date.year
        var curMonth = date.month
        curMonth = curMonth + step
        if curMonth > 12 && step > 0 {
            curMonth = 1
            year = year + 1
        }
        else if curMonth < 1 && step < 0{
            curMonth = 12
            year = year - 1
        }
        
        let monthDateString = String(year) + "-" + String(curMonth) + "-" + String(date.day)
        return monthDateString
    }
    
    
    // 获取某月某天是周几
    func getWeekBy(_ dateString:String, andFirstDay:Int) -> Int {
        let (year, month, _) = getYMDTuppleBy(dateString)
        let weekDay = getWeekDayBy(year, month: month, day: andFirstDay)
        
        return weekDay
    }
    
    // 获取一个月有几天
    func getDaysOfMonthBy(_ year:Int, month:Int) -> Int {
        if month < 1 || month > 12 {
            return 0
        }
        
        if getIsLeapBy(year) {
            return CalendarConstant.DAYS_OF_MONTH_LEAP_YEAR[month]
        }
        
        return CalendarConstant.DAYS_OF_MONTH_NORMAL_YEAR[month]
    }
    
    // 计算一年中过去的天数，含指定的这天
    func calcYearPassDays(_ year:Int, month:Int, day:Int) -> Int {
        var passedDays = 0
        for i in 0 ..< month - 1 {
            if getIsLeapBy(year) {
                passedDays += CalendarConstant.DAYS_OF_MONTH_LEAP_YEAR[i]
            }else{
                passedDays += CalendarConstant.DAYS_OF_MONTH_NORMAL_YEAR[i]
            }
        }
        
        passedDays += day
        
        return passedDays
    }
    
    // 计算一年剩下的天数，不含指定的这天
    func calcYearRestDays(_ year:Int, month:Int, day:Int) -> Int{
        var leftDays = 0
        if getIsLeapBy(year) {
            leftDays = CalendarConstant.DAYS_OF_MONTH_LEAP_YEAR[month] - day
        }else{
            leftDays = CalendarConstant.DAYS_OF_MONTH_NORMAL_YEAR[month] - day
        }
        
        for i in month ..< CalendarConstant.MONTHES_FOR_YEAR {
            if getIsLeapBy(year) {
                leftDays += CalendarConstant.DAYS_OF_MONTH_LEAP_YEAR[i]
            }else{
                leftDays += CalendarConstant.DAYS_OF_MONTH_NORMAL_YEAR[i]
            }
        }
        
        return leftDays
    }
    
    // 计算二个年份之间的天数 前面包含元旦，后面不包含
    func calcYearsDays(_ yearStart:Int, yearEnd:Int) -> Int {
        var days = 0
        for i in yearStart ..< yearEnd {
            if getIsLeapBy(i) {
                days += CalendarConstant.DAYS_OF_LEAP_YEAR
            }else{
                days += CalendarConstant.DAYS_OF_NORMAL_YEAR
            }
        }
        
        return days
    }
    
    // 计算二个指定日期之间的天数
    func calcDaysBetweenDate(_ yearStart:Int, monthStart:Int, dayStart:Int, yearEnd:Int, monthEnd:Int, dayEnd:Int) -> Int {
        var days = calcYearRestDays(yearStart, month: monthStart, day: dayStart)
        
        if yearStart != yearEnd {
            if yearEnd - yearStart >= 2 {
                days += calcYearsDays(yearStart + 1, yearEnd: yearEnd)
            }
            days += calcYearPassDays(yearEnd, month: monthEnd, day: dayEnd)
        }else{
            days -= calcYearRestDays(yearEnd, month: monthEnd, day: dayEnd)
        }
        
        return days
    }
    
    // 判定日期是否使用了格里历
    func isGregorianDays(_ year:Int, month:Int, day:Int) -> Bool {
        if year < CalendarConstant.GREGORIAN_CALENDAR_OPEN_YEAR {
            return false
        }
        if year == CalendarConstant.GREGORIAN_CALENDAR_OPEN_YEAR {
            if (month < CalendarConstant.GREGORIAN_CALENDAR_OPEN_MONTH)
                || (month == CalendarConstant.GREGORIAN_CALENDAR_OPEN_MONTH && day < CalendarConstant.GREGORIAN_CALENDAR_OPEN_DAY){
                return false
            }
        }
        
        return true
    }
    
    
    // 计算儒略日
    func calcJulianDay(_ year:Int, month:Int, day:Int, hour:Int, min:Int, second:Double) -> Double {
        var year = year
        var month = month
        
        if month < 12 {
            month += 12
            year -= 1
        }
        var B = -2
        
        if isGregorianDays(year, month: month, day: day) {
            B = year / 400 - year / 100
        }
        let a = 365.25 * Double(year)
        let b = 30.6001 * Double(month - 1)
        
        let sec:Double =  Double(hour) / 24.0 + Double(min) / 1440.0 + Double(second) / 86400.0
        let param:Double = Double(Int(a)) + Double(Int(b)) + Double(B) + Double(day)
        let res = param + sec + 1720996.5
        
        return res
    }
    
    // 儒略日获得日期
    func getDayTimeFromJulianDay(_ jd:Double, dt:inout WZDayTime){
        var cna:Int, cnd:Int
        var cnf:Double
        
        let jdf:Double = jd + 0.5
        cna = Int(jdf)
        cnf = jdf - Double(cna)
        if cna > 2299161 {
            cnd = Int((Double(cna) - 1867216.25) / 36524.25)
            cna = cna + 1 + cnd - Int(cnd / 4)
        }
        cna = cna + 1524
        var year = Int((Double(cna) - 122.1) / 365.25)
        cnd = cna - Int(Double(year) * 365.25)
        var month = Int(Double(cnd) / 30.6001)
        let day = cnd - Int(Double(month) * 30.6001)
        year -= 4716
        month = month - 1
        if month > 12 {
            month -= 1
        }
        if month <= 2 {
            year += 1
        }
        if year < 1 {
            year -= 1
        }
        cnf = cnf * 24.0
        dt.hour = Int(cnf)
        cnf = cnf - Double(dt.hour)
        cnf *= 60.0
        dt.minute = Int(cnf)
        cnf = cnf - Double(dt.minute)
        dt.second = cnf * 60.0
        dt.year = year
        dt.month = month
        dt.day = day
    }
    
    
    
    // 360度转换
    func mod360Degree(_ degrees:Double) -> Double {
        
        var dbValue:Double = degrees
    
        while dbValue < 0.0{
            dbValue += 360.0
        }
        
        while dbValue > 360.0{
            dbValue -= 360.0
        }
    
        return dbValue;
    }
    
    // 角度转弧度
    func degree2Radian(_ degree:Double) -> Double {
        return degree * CalendarConstant.PI / 180.0
    }
    // 弧度转角度
    func radian2Degree(_ radian:Double) -> Double {
        return radian * 180.0 / CalendarConstant.PI
    }
}
