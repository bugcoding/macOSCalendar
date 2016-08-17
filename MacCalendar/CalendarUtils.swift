/*====================
 
 FileName    : CalendarUtils
 Desc        : Utils Function For Calendar (singleton class)
 Author      : bugcode
 Email       : bugcoding@gmail.com
 CreateDate  : 2016-5-8
 
 ====================*/

import Foundation

public class CalendarUtils{
    
    // singleton implemention
    class var sharedInstance : CalendarUtils{
        
        struct Static{
            static let ins:CalendarUtils = CalendarUtils()
        }
        return Static.ins
    }
    private init(){
        
    }
    
    // days every month
    // leap year
    var daysOfMonthLeapYear = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    // not leap year
    var daysOfMonthNotLeapYear = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    // Chinese era,ce,Heavenly Stems and Earthy Branches
    var heavenlyStems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    var earthyBranches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    // Chinese Zodic
    var chineseZodiacName = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    
    // get weekday by specail date, use Zeller Formular
    func getWeekDayBy(year:Int, month m:Int, day d:Int) -> Int {
        // Zeller Formular
        var year = year
        var m = m
        if m < 3 {
            year -= 1
            m += 12
        }
        
        // last two digits of year number. 2003 -> 03 | 1997 -> 97
        let y:Int = year % 100
        // The preceding 2 digits of year number. 2003 -> 20 | 1997 -> 19
        let c:Int = Int(year / 100)
        
        var week:Int = Int(c / 4) - 2 * c + y + Int(y / 4) + (26 * (m + 1) / 10) + d - 1

        week = (week % 7 + 7) % 7
        
        return week
    }
    
    // Get lunar calender year name GanZhi
    func getLunarYearNameBy(year:Int) -> (heaven:String, earthy:String, zodiac:String){
        let baseMinus:Int = year - 2000
        
        var heavenly = (7 + baseMinus) % 10
        var earth = (5 + baseMinus) % 12
        
        // negative number handling
        if heavenly <= 0 {
            heavenly += 10
        }
        if earth <= 0 {
            earth += 12
        }
        
        return (heavenlyStems[heavenly - 1], earthyBranches[earth - 1], chineseZodiacName[earth - 1])
    }
    
    // current year is leap year or not
    func getIsLeapBy(year:Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    }
    
    // how many days in special month
    func getDaysBy(dateString: String) -> Int {
        let (year, m, _) = getYMDTuppleBy(dateString)
        var days = 0
        if getIsLeapBy(year) {
            days = daysOfMonthLeapYear[m]
        }
        else{
            days = daysOfMonthNotLeapYear[m]
        }
        return days
    }
    
    // get date of today
    func getDateStringOfToday() -> String {
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.stringFromDate(nowDate)
        return dateString
    }
    
    // get year, month, day from date string, keep dateString valid by caller
    func getYMDTuppleBy(dateString:String) -> (year:Int, month:Int, day:Int) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.dateFromString(dateString)
        
        formatter.dateFormat = "yyyy"
        let y = formatter.stringFromDate(date!)
        
        formatter.dateFormat = "MM"
        let m = formatter.stringFromDate(date!)
        
        formatter.dateFormat = "dd"
        let d = formatter.stringFromDate(date!)
        
        return (Int(y)!, Int(m)!, Int(d)!)
    }
    
    // get next month dateString
    func getMonthDateStringBy(dateString:String, step:Int)->String {
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
        
        // construct next month date format string
        let monthDateString = String(year) + "-" + String(curMonth) + "-" + String(date.day)
        return monthDateString
    }
    
    
    // get week day which month of first day
    func getWeekBy(dateString:String, andFirstDay:Int) -> Int {
        let (year, month, _) = getYMDTuppleBy(dateString)
        let weekDay = getWeekDayBy(year, month: month, day: andFirstDay)
        
        return weekDay
    }
    
    
    
    
    
    
    
    
    
}
