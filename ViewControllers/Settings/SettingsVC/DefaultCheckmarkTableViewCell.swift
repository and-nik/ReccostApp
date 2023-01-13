//
//  DefaultCheckmarkTableViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DefaultCheckmarkTableViewCell : UITableViewCell
{
    static let reuseID = "DefaultCheckmarkTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.tintColor = appTintColor
        self.backgroundColor = appCellBackgroundColor
        
        //self.addSubview(GlobalFunctional.addBlurEffect(bounds: self.bounds))
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(text: String)
    {
        self.textLabel?.text = text
        self.detailTextLabel?.text = "fffff"
    }
}
