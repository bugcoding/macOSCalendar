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
   
    
    func getEarthNutationParameter(dt:Double, D:inout Double, M:inout Double, Mp:inout Double, F:inout Double, Omega:inout Double)
    {
        let T = dt * 10; /*T是从J2000起算的儒略世纪数*/
        let T2 = T * T;
        let T3 = T2 * T;
    
        /*平距角（如月对地心的角距离）*/
        D = 297.85036 + 445267.111480 * T - 0.0019142 * T2 + T3 / 189474.0;
        
        /*太阳（地球）平近点角*/
        M = 357.52772 + 35999.050340 * T - 0.0001603 * T2 - T3 / 300000.0;
        
        /*月亮平近点角*/
        Mp = 134.96298 + 477198.867398 * T + 0.0086972 * T2 + T3 / 56250.0;
        
        /*月亮纬度参数*/
        F = 93.27191 + 483202.017538 * T - 0.0036825 * T2 + T3 / 327270.0;
        
        /*黄道与月亮平轨道升交点黄经*/
        Omega = 125.04452 - 1934.136261 * T + 0.0020708 * T2 + T3 / 450000.0;
    }

    /*计算某时刻的黄经章动干扰量，dt是儒略千年数，返回值单位是度*/
    func calcEarthLongitudeNutation(dt:Double) -> Double {
        let T = dt * 10
        var D:Double = 0.0, M:Double = 0.0, Mp:Double = 0.0, F:Double = 0.0, Omega:Double = 0.0
        
        getEarthNutationParameter(dt: dt, D: &D, M: &M, Mp: &Mp, F: &F, Omega: &Omega)
        
        var resulte = 0.0 ;
        for (i, _) in CalendarConstant.nutation.enumerated() {
            
            var sita = CalendarConstant.nutation[i].D * D + CalendarConstant.nutation[i].M * M + CalendarConstant.nutation[i].Mp * Mp + CalendarConstant.nutation[i].F * F + CalendarConstant.nutation[i].omega * Omega;
            sita = degree2Radian(sita);
            
            resulte += (CalendarConstant.nutation[i].sine1 + CalendarConstant.nutation[i].sine2 * T ) * sin(sita);
        }
        
        /*先乘以章动表的系数 0.0001，然后换算成度的单位*/
        return resulte * 0.0001 / 3600.0;
    }
    
    
    /*计算某时刻的黄赤交角章动干扰量，dt是儒略千年数，返回值单位是度*/
    func calcEarthObliquityNutation(dt:Double) -> Double {
        // T是从J2000起算的儒略世纪数
        let T = dt * 10
        var D = 0.0, M = 0.0, Mp = 0.0, F = 0.0, Omega = 0.0
    
        getEarthNutationParameter(dt:dt, D: &D, M: &M, Mp: &Mp, F: &F, Omega: &Omega)
    
        var resulte = 0.0 ;
        for(i, _) in CalendarConstant.nutation.enumerated() {
            var sita = CalendarConstant.nutation[i].D * D + CalendarConstant.nutation[i].M * M + CalendarConstant.nutation[i].Mp * Mp + CalendarConstant.nutation[i].F * F + CalendarConstant.nutation[i].omega * Omega;
            sita = degree2Radian(sita);
            
            resulte += (CalendarConstant.nutation[i].cosine1 + CalendarConstant.nutation[i].cosine2 * T ) * cos(sita);
        }
    
        // 先乘以章动表的系数 0.001，然后换算成度的单位
        return resulte * 0.0001 / 3600.0;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
