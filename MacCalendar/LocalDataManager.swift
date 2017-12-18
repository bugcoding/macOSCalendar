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
}

