//
//  MonthCollectionViewCell.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class MonthCollectionViewCell : UICollectionViewCell
{
    static let reuseID = "MonthCollectionViewCell"
    
    private let infoView = UIView()
    private func infoViewConfig()
    {
        self.infoView.backgroundColor = appCellBackgroundColor
        self.infoView.translatesAutoresizingMaskIntoConstraints = false

        self.infoView.layer.cornerRadius = self.frame.width/4
        
        self.addSubview(self.infoView)
        
        self.infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.1
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private let monthLabel = UILabel()
    private func monthLabelConfig()
    {
        self.monthLabel.text = "Sep 2020"
        
        self.monthLabel.numberOfLines = 2
        self.monthLabel.font = .boldSystemFont(ofSize: 23)
        self.monthLabel.textAlignment = .left
        
        self.monthLabel.frame = CGRect(x: 20, y: 10, width: 70, height: 70)
        
        self.addSubview(self.monthLabel)
    }
    
    private let nowLabel = UILabel()
    private func nowLabelConfig()
    {
        self.nowLabel.text = "Now"
        
        self.nowLabel.numberOfLines = 1
        self.nowLabel.font = .systemFont(ofSize: 18)
        self.nowLabel.textColor = .white
        self.nowLabel.textAlignment = .left
        
        self.nowLabel.frame = CGRect(x: 20, y: 5, width: 90, height: 15)
        
        self.addSubview(self.nowLabel)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.infoViewConfig()
        self.monthLabelConfig()
        self.nowLabelConfig()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func cellConfig(textDate: String)
    {
        self.monthLabel.text = textDate
    }
    
    func selectedCell()
    {
        self.nowLabel.isHidden = false
        self.monthLabel.textColor = .white
        self.infoView.backgroundColor = appTintColor
    }
    
    func deselectedCell()
    {
        self.nowLabel.isHidden = true
        self.infoView.backgroundColor = appCellBackgroundColor
        self.monthLabel.textColor = appTitleColor
    }
    
    func animate()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.frame = CGRect(x: 0, y: 20, width: self.infoView.bounds.width, height: self.infoView.bounds.height)})
        print("..........")
    }
}
