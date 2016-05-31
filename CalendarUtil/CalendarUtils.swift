/*====================
 
    FileName    : CalendarUtils singleton
    Desc        : Utils Function For Calendar
    Author      : bugcode
    Email       : bugcoding@gmail.com
    CreateDate  : 2016-5-8
 
 ====================*/


public class CalendarUtils
{
    // singleton implemention
    class var sharedInstance : CalendarUtils
    {
        struct Static
        {
            static let ins:CalendarUtils = CalendarUtils()
        }
        return Static.ins
    }
    private init()
    {
        
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
    func getWeekDayBy(year:Int, month m:Int, day d:Int) -> Int
    {
        // Zeller Formular
        // w = (y + floor(y / 4) + floor(c / 4) - 2c + (13(m + 1) / 5) + d - 1) % 7
        
        // last 2 of year number. 2003 -> 03 | 1997 -> 97
        let y:Int = year % 100
        // The preceding 2 digits of year number. 2003 -> 20 | 1997 -> 19
        let c:Int = year / 100
        
        var week:Int = (y + y / 4 + c / 4 - 2 * c + (13 * (m + 1) / 5) + d - 1) % 7;
        
        // negative number handle
        if week < 0
        {
            week += 7
        }
        
        return week
    }
    
    // Get lunar calender year name GanZhi
    func getLunarYearNameBy(year:Int) -> (heaven:String, earthy:String, zodiac:String)
    {
        let baseMinus:Int = year - 2000
        
        var heavenly = (7 + baseMinus) % 10
        var earth = (5 + baseMinus) % 12
        
        // negative number handle
        if heavenly <= 0
        {
            heavenly += 10
        }
        if earth <= 0
        {
            earth += 12
        }
        
        return (heavenlyStems[heavenly - 1], earthyBranches[earth - 1], chineseZodiacName[earth - 1])
    }
    
    // current year is leap year or not
    func getIsLeapBy(year:Int) -> Bool
    {
        var isLeap = false
        isLeap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        return isLeap
    }
    
    // how many days in special month
    func getDaysBy(year:Int, month m:Int) -> Int
    {
        var days = 0
        if getIsLeapBy(year)
        {
            days = daysOfMonthLeapYear[m]
        }
        else
        {
            days = daysOfMonthNotLeapYear[m]
        }
        return days
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}