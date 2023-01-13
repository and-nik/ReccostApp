//
//  EditTableViewControllerCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class EditTableViewControllerCell : UITableViewCell
{
    static let reuseID = "EditTableViewControllerCell"
    
    let textField = UITextField()
    func textFieldConfig()
    {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.textField.tintColor = appTintColor
        
        self.contentView.addSubview(self.textField)
        
        self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = appCellBackgroundColor
        
        self.textFieldConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(text: String)
    {
        self.textField.text = text
    }
}
