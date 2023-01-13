//
//  DaysCategoriesTableViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DaysCategoriesTableViewCell : UITableViewCell
{
    static let reuseID = "DaysCategoriesTableView"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appCellBackgroundColor
        
        self.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.1
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 30).isActive = true
    }
    
    let nameTextView = UITextView()
    func nameTextViewConfig()
    {
        self.nameTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameTextView.backgroundColor = .clear
        self.nameTextView.font = .systemFont(ofSize: 18)
        
        self.nameTextView.showsVerticalScrollIndicator = true
        self.nameTextView.isEditable = false
        self.nameTextView.isScrollEnabled = true
        
        self.infoView.addSubview(self.nameTextView)
        
        self.nameTextView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 85).isActive = true
        self.nameTextView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.nameTextView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.nameTextView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    let countOfPaymentsLabel = UILabel()
    func countOfPaymentsLabelConfig()
    {
        self.countOfPaymentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.countOfPaymentsLabel.textColor = appTintColor
        self.countOfPaymentsLabel.font = .boldSystemFont(ofSize: 20)
        self.countOfPaymentsLabel.textAlignment = .center
        
        self.infoView.addSubview(self.countOfPaymentsLabel)
        
        self.countOfPaymentsLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 195).isActive = true
        self.countOfPaymentsLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.countOfPaymentsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.countOfPaymentsLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let totalPriceLabel = UILabel()
    func totalPriceLabelConfig()
    {
        self.totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.totalPriceLabel.font = .systemFont(ofSize: 18)
        self.totalPriceLabel.textAlignment = .right
        
        self.infoView.addSubview(self.totalPriceLabel)
        
        self.totalPriceLabel.leftAnchor.constraint(equalTo: self.countOfPaymentsLabel.rightAnchor).isActive = true
        self.totalPriceLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.totalPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.totalPriceLabel.rightAnchor.constraint(equalTo: self.chevronImageView.leftAnchor, constant: -10).isActive = true
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.infoView.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -20).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.infoViewConfig()
        self.iconImageViewConfig()
        self.nameTextViewConfig()
        self.countOfPaymentsLabelConfig()
        self.chevronImageViewConfig()
        self.totalPriceLabelConfig()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.infoView.layer.cornerRadius = self.infoView.bounds.height/2
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        //self.animate()
    }
    
    func showSmoothCell()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.alpha = 1})
    }
    
    func cellConfig(category: CategoryContent)
    {
        self.iconImageView.image = category.getImage()
        self.nameTextView.text = category.getName()
        self.countOfPaymentsLabel.text = String(category.history.count)
        self.totalPriceLabel.text = "\(GlobalFunctional.getFormatedPriceInString(price: category.totalPrice!))\(SettingsHandler.shared.moneySymbol)"
        self.animate()
    }
    
    func animate()
    {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations:
                        {
            self.infoView.bounds = CGRect(x: Int(self.infoView.bounds.origin.x),
                                          y: Int(self.infoView.bounds.origin.y),
                                          width: Int(self.infoView.bounds.width) + 40,
                                          height: Int(self.infoView.bounds.height) + 20)})
    }
}
