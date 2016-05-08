/*====================
 
    FileName    : CalendarUtils
    Desc        : Utils Function For Calendar
    Author      : bugcode
    Email       : bugcoding@gmail.com
    CreateDate  : 2016-5-8
 
 ====================*/


public class CalendarUtils
{
    // get weekday by specail date, use Zeller Formular
    func getWeekDayBy(year:Int, month:Int, day:Int) -> Int
    {
        // Zeller Formular
        // w = (y + floor(y / 4) + floor(c / 4) - 2c + (13(m + 1) / 5) + d - 1) % 7
        
        // last 2 of year number. 2003 -> 03 | 1997 -> 97
        let y:Int = year % 100
        // The preceding 2 digits of year number. 2003 -> 20 | 1997 -> 19
        let c:Int = year / 100
        
        var week:Int = (y + y / 4 + c / 4 - 2 * c + (13 * (month + 1) / 5) + day - 1) % 7;
        
        // negative number handle
        if week < 0
        {
            week += 7
        }
        
        return week
    }
}