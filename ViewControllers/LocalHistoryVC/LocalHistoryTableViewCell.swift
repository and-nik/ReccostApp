//
//  LocalHistoryTableViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class LocalHistoryTableViewCell : UITableViewCell
{
    static let reuseID = "HistoryTableViewCell"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appBackgroundColor
        
        self.contentView.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.infoView.layoutIfNeeded()
        self.infoView.layer.cornerRadius = 29
        
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.2
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 20).isActive = true
        
        self.iconImageView.layer.cornerRadius = 2
    }
    
    let categoryNameLabel = UILabel()
    func categoryNameLabelConfig()
    {
        self.categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameLabel.textColor = appTitleColor
        self.categoryNameLabel.font = .systemFont(ofSize: 18)
        self.categoryNameLabel.textAlignment = .left
        
        self.infoView.addSubview(self.categoryNameLabel)
        
        self.categoryNameLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.categoryNameLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
        self.categoryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.categoryNameLabel.rightAnchor.constraint(equalTo: self.dateLabel.leftAnchor, constant: -10).isActive = true
    }
    
    let priceLabel = UILabel()
    func priceLabelConfig()
    {
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceLabel.textColor = appTintColor
        self.priceLabel.font = .boldSystemFont(ofSize: 40)
        self.priceLabel.textAlignment = .left
        
        self.infoView.addSubview(self.priceLabel)
        
        self.priceLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.priceLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -10).isActive = true
    }
    
    let descriptionTextView = UITextView()
    func descriptionTextViewConfig()
    {
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionTextView.backgroundColor = .none
        self.descriptionTextView.font = .systemFont(ofSize: 12)
        self.descriptionTextView.textColor = .secondaryLabel
        
        self.descriptionTextView.showsVerticalScrollIndicator = true
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.isScrollEnabled = true
        
        self.infoView.addSubview(self.descriptionTextView)
        
        self.descriptionTextView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.descriptionTextView.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -5).isActive = true
        self.descriptionTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.descriptionTextView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    let dateLabel = UILabel()
    func dateLabelConfig()
    {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLabel.textColor = .secondaryLabel
        self.dateLabel.font = .systemFont(ofSize: 18)
        self.dateLabel.textAlignment = .right
        
        self.infoView.addSubview(self.dateLabel)
        
        self.dateLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -20).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.dateLabel.widthAnchor.constraint(equalToConstant: 145).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.infoViewConfig()
        self.iconImageViewConfig()
        
        self.priceLabelConfig()
        self.descriptionTextViewConfig()
        self.dateLabelConfig()
        
        self.categoryNameLabelConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(category: CategoryContent, eventData: EventData)
    {
        self.iconImageView.image = category.getImage()
        self.categoryNameLabel.text = category.getName()
        self.priceLabel.text = "\(GlobalFunctional.getFormatedPriceInString(price: eventData.getPrice()))\(SettingsHandler.shared.moneySymbol)"
        if eventData.getDescription() == ""
        {
            self.descriptionTextView.text = "No description"
        }
        else
        {
            self.descriptionTextView.text = eventData.getDescription()
        }
        self.dateLabel.text = eventData.getStringDate()
    }
    
    func animate(){
        let viewBounds = self.infoView.bounds
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       usingSpringWithDamping:0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {self.contentView.layoutIfNeeded()})
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
            
            self.infoView.bounds = CGRect(x: Int(viewBounds.origin.x),
                                          y: Int(viewBounds.origin.y),
                                          width: Int(viewBounds.width) + 40,
                                          height: Int(viewBounds.height) + 20)
        })
        
        let animator = UIViewPropertyAnimator(duration: 0.5,
                                              curve: .easeIn,
                                              animations: {self.infoView.backgroundColor = .systemGray5
        })
        animator.startAnimation()
    }
    
}
