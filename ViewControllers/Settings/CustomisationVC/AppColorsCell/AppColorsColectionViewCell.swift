//
//  AppColorsColectionViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class AppColorsColectionViewCell : UICollectionViewCell
{
    static let reuseID = "AppColorsColectionViewCell"
    
    let colorView = UIView()
    func colorViewConfig()
    {
        self.colorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.colorView.layer.cornerRadius = self.bounds.height/2
        
        self.contentView.addSubview(self.colorView)
        
        self.colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.colorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.colorViewConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(color: UIColor)
    {
        self.colorView.backgroundColor = color
    }
}

