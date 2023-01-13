//
//  DataHandler.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DataHandler
{
    static let shared = DataHandler()
    
    private var userDefaults = UserDefaults.standard
    
    
    func saveMoneySymbol(moneySymbol: String)
    {
        guard let data = try? JSONEncoder().encode(moneySymbol) else {return}
        userDefaults.set(data, forKey: SettingsKays.moneySymbol)
    }
    func loadMoneySymbol() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.moneySymbol) as? Data else {return String()}
        guard let moneySymbol = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return moneySymbol
    }
    
    func saveAppLanguage(appLanguage: String)
    {
        guard let data = try? JSONEncoder().encode(appLanguage) else {return}
        userDefaults.set(data, forKey: SettingsKays.appLanguage)
    }
    func loadAppLanguage() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appLanguage) as? Data else {return String()}
        guard let appLanguage = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appLanguage
    }
    
    func saveAppTapSoundName(appTapSoundName: String)
    {
        guard let data = try? JSONEncoder().encode(appTapSoundName) else {return}
        userDefaults.set(data, forKey: SettingsKays.appTapSoundName)
    }
    func loadAppTapSoundName() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appTapSoundName) as? Data else {return String()}
        guard let appTapSoundName = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appTapSoundName
    }
    
    func saveAppTintColorName(appTintColorName: String)
    {
        guard let data = try? JSONEncoder().encode(appTintColorName) else {return}
        userDefaults.set(data, forKey: SettingsKays.appTintColorName)
    }
    func loadAppTintColorName() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appTintColorName) as? Data else {return String()}
        guard let appTintColorName = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appTintColorName
    }
    
    
    
    //MARK: currency Array handler
    
    private var currencyArrayKey = "currencyArrayKey"
    
    func saveCurrencyArray(newArray:[String])
    {
        guard let data = try? JSONEncoder().encode(newArray) else {print("jjjj");return}
        userDefaults.set(data, forKey: self.currencyArrayKey)
    }
    
    func loadCurrencyArray() -> [String]
    {
        guard let data = self.userDefaults.object(forKey: self.currencyArrayKey) as? Data else {print("jjjjoooo");return []}
        guard let currencyArray = try? JSONDecoder().decode([String].self, from: data) else {print("jjjjppp");return []}

        return currencyArray
    }
    
    
    
    //MARK: userMonth Array handler
    
    private var userMonthKey = "userMonthKey"
    
    func saveUsersMonthArray(newArray:[MonthContent])
    {
        guard let data = try? JSONEncoder().encode(newArray) else {return}
        userDefaults.set(data, forKey: self.userMonthKey)
    }
    
    func loadUsersMonthArray() -> [MonthContent]
    {
        guard let data = self.userDefaults.object(forKey: self.userMonthKey) as? Data else {return []}
        guard let events = try? JSONDecoder().decode([MonthContent].self, from: data) else {return []}

        return events
    }
    
    
    
    //MARK: allCategory Array handler
    
    private var allCategoriesKey = "allCategoriesKey"
    
    func setDataCategories(events:[CategoryContent])
    {
        guard let data = try? JSONEncoder().encode(events) else {return}
        userDefaults.set(data, forKey: self.allCategoriesKey)
    }
    
    func loadDataCategories() -> [CategoryContent]
    {
        guard let data = userDefaults.object(forKey: self.allCategoriesKey) as? Data else {return []}
        guard let events = try? JSONDecoder().decode([CategoryContent].self, from: data) else {return []}
        
        return events
    }
}
