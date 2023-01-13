//
//  CategoriesTableViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit
import AVFoundation

class CategoriesTableViewCell : UITableViewCell
{
    static let reuseID = "CategoriesTableViewCell"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.frame = CGRect(x: 0, y: 0, width: 0, height: 70)
        self.infoView.backgroundColor = .none
        
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.cornerRadius = self.infoView.frame.height/7
        
        //self.infoView.addSubview(GlobalFunctional.addBlurEffect(bounds: self.infoView.bounds))
        
        self.contentView.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 35).isActive = true
    }
    
    let categoryNameLabel = UILabel()
    func categoryNameLabelConfig()
    {
        self.categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameLabel.textColor = appTitleColor
        self.categoryNameLabel.font = .systemFont(ofSize: 18)
        self.categoryNameLabel.textAlignment = .left
        
        self.infoView.addSubview(self.categoryNameLabel)
        
        self.categoryNameLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 95).isActive = true
        self.categoryNameLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.categoryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.categoryNameLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -40).isActive = true
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.infoView.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -30).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        
        self.infoViewConfig()
        
        self.iconImageViewConfig()
        self.categoryNameLabelConfig()
        self.chevronImageViewConfig()
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(category: CategoryContent)
    {
        self.iconImageView.image = category.getImage()
        self.categoryNameLabel.text = category.getName()
    }
}
