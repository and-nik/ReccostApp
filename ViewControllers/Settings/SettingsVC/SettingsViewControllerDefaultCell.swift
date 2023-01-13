//
//  SettingsViewControllerDefaultCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class SettingsViewControllerDefaultCell : UITableViewCell
{
    static let reuseID = "SettingsViewControllerDefaultCell"
    
    let iconImageContainerView = UIView()
    func iconImageContainerViewConfig()
    {
        self.iconImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconImageContainerView.layer.cornerRadius = 8
        
        self.addSubview(self.iconImageContainerView)
        
        self.iconImageContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.iconImageContainerView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.iconImageContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.iconImageContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.iconImageContainerView.addSubview(self.iconImageView)
        
        self.iconImageView.leadingAnchor.constraint(equalTo: self.iconImageContainerView.leadingAnchor, constant: 5).isActive = true
        self.iconImageView.trailingAnchor.constraint(equalTo: self.iconImageContainerView.trailingAnchor, constant: -5).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: self.iconImageContainerView.topAnchor, constant: 5).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: self.iconImageContainerView.bottomAnchor, constant: -5).isActive = true
    }
    
    let titleLabel = UILabel()
    func titleLabelConfig()
    {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.textAlignment = .left
        
        self.addSubview(self.titleLabel)
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 100).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    let descriptionLabel = UILabel()
    func descriptionLabelConfig()
    {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionLabel.textAlignment = .right
        self.descriptionLabel.textColor = .secondaryLabel
        
        self.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 250).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.iconImageContainerViewConfig()
        self.iconImageViewConfig()
        self.titleLabelConfig()
        self.descriptionLabelConfig()
        
        self.selectionStyle = .none
        self.backgroundColor = appCellBackgroundColor
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(image: UIImage, name: String, backgroundColor: UIColor)
    {
        self.iconImageView.image = image
        self.iconImageView.tintColor = .white
        self.iconImageContainerView.backgroundColor = backgroundColor
        self.titleLabel.text = name
    }
    
    func cellDescription(description: String)
    {
        self.descriptionLabel.text = description
    }
}
