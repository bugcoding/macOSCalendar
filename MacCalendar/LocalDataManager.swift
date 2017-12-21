//
//  LocalDataManager.swift
//  StatebarCalendar
//
//  Created by bugcode on 2017/12/10.
//  Copyright © 2017年 bugcode. All rights reserved.
//

import Foundation

class LocalDataManager {
    // 单例
    class var sharedInstance : LocalDataManager {
        
        struct Static{
            static let ins:LocalDataManager = LocalDataManager()
        }
        return Static.ins
    }
    fileprivate init(){
        
    }
    
    // 存储数据
    func saveData(data: Any, forKey: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.setValue(data, forKey: forKey)
    }
    
    // 取出数据
    func popData(forKey: String) -> Data? {
        let data = UserDefaults.standard.value(forKey: forKey)
        return data as? Data
    }
    
    // 置空某个key对应的值
    func removeData(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    // 获取当前日期是否有标记
    func getCurDateFlag(wzDay: CalendarUtils.WZDayTime) -> String {
        let str = String(describing: wzDay.year) + String(describing: wzDay.month) + String(describing: wzDay.day)
        //Swift.print("wzDay = \(str)")
        
        if let data = LocalDataManager.sharedInstance.popData(forKey: str) {
            let info = NSKeyedUnarchiver.unarchiveObject(with: data) as! String
            return info
        }
        return ""
    }
}

