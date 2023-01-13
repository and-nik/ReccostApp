//
//  MonthCollecttionView.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class MonthCollecttionView : UICollectionView
{
    init()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.minimumLineSpacing = 30
        
        self.contentInset = UIEdgeInsets(top: 80, left: 40, bottom: 0, right: 40)
        self.contentMode = .center
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.backgroundColor = appBackgroundColor
        
        self.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.reuseID)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
