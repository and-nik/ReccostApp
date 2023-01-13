//
//  SettingsCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

struct SettingsCell
{
    var iconImage:UIImage
    var titel:String
    var backgroundColor: UIColor
    
    init(iconImage: UIImage, titel: String, backgroundColor: UIColor)
    {
        self.iconImage = iconImage
        self.titel = titel
        self.backgroundColor = backgroundColor
    }
}
