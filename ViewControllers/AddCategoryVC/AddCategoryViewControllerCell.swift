//
//  AddCategoryViewControllerCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class AddCategoryViewControllerCell : UICollectionViewCell
{
    static let reuseID = "CategoriesTableViewCell"
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconImageView.image = UIImage(named: "tap")
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.iconImageView)
        
        self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.height/4
        self.layer.masksToBounds = true
        self.backgroundColor = appBackgroundColor
        
        self.iconImageViewConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(image: UIImage)
    {
        self.iconImageView.image = image
    }
}
