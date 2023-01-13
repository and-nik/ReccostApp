//
//  SettingsHandler.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class SettingsHandler : Codable
{
    static var shared = SettingsHandler()
    
    var appTintColorName : String
    {
        get { return DataHandler.shared.loadAppTintColorName() }
        set { DataHandler.shared.saveAppTintColorName(appTintColorName: newValue) }
    }
    var moneySymbol : String
    {
        get { return DataHandler.shared.loadMoneySymbol() }
        set { DataHandler.shared.saveMoneySymbol(moneySymbol: newValue) }
    }
    var appLanguage: String
    {
        get { return DataHandler.shared.loadAppLanguage() }
        set { DataHandler.shared.saveAppLanguage(appLanguage: newValue) }
    }
    var appTapSoundName: String
    {
        get { return DataHandler.shared.loadAppTapSoundName() }
        set { DataHandler.shared.saveAppTapSoundName(appTapSoundName: newValue) }
    }
    var isSoundOn: Bool = true
    var isVibrationOn: Bool = true
}
