//
//  GlobalValues.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit
import AVFoundation

//MARK: - Customisation

var appBackgroundColor: UIColor = .systemGroupedBackground
var appCellBackgroundColor: UIColor = .secondarySystemGroupedBackground
var appTitleColor: UIColor = .label

var appTintColor: UIColor
{
    get
    {
        switch SettingsHandler.shared.appTintColorName
        {
        case ColorsKey.systemBlue: return .systemBlue
        case ColorsKey.systemGreen: return .systemGreen
        case ColorsKey.systemYellow: return .systemYellow
        case ColorsKey.systemRed: return .systemRed
        case ColorsKey.MClightPink: return .MClightPink
        case ColorsKey.systemMint: return .systemMint
        case ColorsKey.systemOrange: return .systemOrange
        case ColorsKey.systemCyan: return .systemCyan
        case ColorsKey.systemIndigo: return .systemIndigo
        case ColorsKey.systemPurple: return .systemPurple
        default: return .systemBlue
        }
    }
    set
    {
        switch newValue
        {
        case .systemBlue: SettingsHandler.shared.appTintColorName = ColorsKey.systemBlue
        case .systemGreen: SettingsHandler.shared.appTintColorName = ColorsKey.systemGreen
        case .systemYellow: SettingsHandler.shared.appTintColorName = ColorsKey.systemYellow
        case .systemRed: SettingsHandler.shared.appTintColorName = ColorsKey.systemRed
        case .MClightPink: SettingsHandler.shared.appTintColorName = ColorsKey.MClightPink
        case .systemMint: SettingsHandler.shared.appTintColorName = ColorsKey.systemMint
        case .systemOrange: SettingsHandler.shared.appTintColorName = ColorsKey.systemOrange
        case .systemCyan: SettingsHandler.shared.appTintColorName = ColorsKey.systemCyan
        case .systemIndigo: SettingsHandler.shared.appTintColorName = ColorsKey.systemIndigo
        case .systemPurple: SettingsHandler.shared.appTintColorName = ColorsKey.systemPurple
        default: break
        }
    }
}


//MARK: - Global values

var audioPlayer : AVAudioPlayer?

let user = UserHandler(image: UIImage(named: "my")!, name: "Big", surname: "Kick")

var usersMonths = [MonthContent]()
var monthCategories = [CategoryContent]()

var selectedMonthIndex = 0
var selectedDayIndex = 0
var selectedCategoryIndex = 0

var allCategories = [CategoryContent(name: "Business", image: #imageLiteral(resourceName: "icon_1")),
                     CategoryContent(name: "Sport", image: #imageLiteral(resourceName: "icon_4")),
                     CategoryContent(name: "Meal", image: #imageLiteral(resourceName: "icon_3")),
                     CategoryContent(name: "Transport", image: #imageLiteral(resourceName: "icon_5")),
                     CategoryContent(name: "Game", image: #imageLiteral(resourceName: "icon_6")),
                     CategoryContent(name: "Travel", image: #imageLiteral(resourceName: "icon_2")),
                     CategoryContent(name: "Home", image: #imageLiteral(resourceName: "icon_7")),
                     CategoryContent(name: "Family", image: #imageLiteral(resourceName: "icon_8")),
                     CategoryContent(name: "Pet", image: #imageLiteral(resourceName: "icon_9")),
                     CategoryContent(name: "Furniture", image: #imageLiteral(resourceName: "icon_10")),
                     CategoryContent(name: "Studies", image: #imageLiteral(resourceName: "icon_11")),
                     CategoryContent(name: "Technics", image: #imageLiteral(resourceName: "icon_12")),
                     CategoryContent(name: "Periphery", image: #imageLiteral(resourceName: "icon_13")),
                     CategoryContent(name: "Applications", image: #imageLiteral(resourceName: "icon_23")),
                     CategoryContent(name: "Presents", image: #imageLiteral(resourceName: "icon_15")),
                     CategoryContent(name: "Taxes", image: #imageLiteral(resourceName: "icon_21")),
                     CategoryContent(name: "Sex", image: #imageLiteral(resourceName: "icon_14")),
                     CategoryContent(name: "Jewelry", image: #imageLiteral(resourceName: "icon_16")),
                     CategoryContent(name: "Farm", image: #imageLiteral(resourceName: "icon_17")),
                     CategoryContent(name: "Clothes", image: #imageLiteral(resourceName: "icon_18")),
                     CategoryContent(name: "Medicines", image: #imageLiteral(resourceName: "icon_20")),
                     CategoryContent(name: "Health", image: #imageLiteral(resourceName: "icon_19")),
                     CategoryContent(name: "Woman Health", image: #imageLiteral(resourceName: "icon_22"))]
