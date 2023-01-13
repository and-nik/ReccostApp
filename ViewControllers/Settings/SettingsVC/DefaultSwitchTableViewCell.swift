//
//  DefaultSwitchTableViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DefaultSwitchTableViewCell : UITableViewCell
{
    static let reuseID = "DefaultSwitchTableViewCell"
    
    let switchOnOff = UISwitch()
    func switchOnOffConfig()
    {
        self.accessoryView = self.switchOnOff
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.tintColor = appTintColor
        self.backgroundColor = appCellBackgroundColor
        
        self.switchOnOffConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(text: String)
    {
        self.textLabel?.text = text
    }
}

