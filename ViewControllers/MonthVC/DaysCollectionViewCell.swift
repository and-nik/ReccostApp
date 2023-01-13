//
//  DaysCollectionViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DaysCollectionViewCell : UICollectionViewCell
{
    static let reuseID = "DaysCollectionViewCell"
    
    private let infoView = UIView()
    private func infoViewConfig()
    {
        self.infoView.backgroundColor = appBackgroundColor
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.cornerRadius = 10
        
        self.addSubview(self.infoView)
        
        self.infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private let dayLabel = UILabel()
    private func dayLabelConfig()
    {
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dayLabel.text = ""
        self.dayLabel.numberOfLines = 2
        self.dayLabel.font = .systemFont(ofSize: 18)
        self.dayLabel.textAlignment = .center
        
        self.infoView.addSubview(self.dayLabel)
        
        self.dayLabel.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor).isActive = true
        self.dayLabel.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor).isActive = true
        self.dayLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor).isActive = true
        self.dayLabel.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.infoViewConfig()
        self.dayLabelConfig()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func cellConfig(textDate: String)
    {
        self.dayLabel.text = textDate
    }
    
    func selectedCell()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.backgroundColor = appTintColor})
        self.dayLabel.textColor = .white
    }
    
    func deselectedCell()
    {
        self.infoView.backgroundColor = appBackgroundColor
        self.infoView.layer.borderWidth = 0
        self.dayLabel.textColor = appTitleColor
    }
    
    func showNowDay()
    {
        self.infoView.layer.borderWidth = 5
        self.infoView.layer.borderColor = appTintColor.cgColor
    }

}
