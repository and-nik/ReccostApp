//
//  IconsCollectionView.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class IconsCollectionView : UICollectionView
{
    init()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.minimumLineSpacing = 30
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.contentMode = .center
        self.backgroundColor = appCellBackgroundColor
        
        self.register(AddCategoryViewControllerCell.self, forCellWithReuseIdentifier: AddCategoryViewControllerCell.reuseID)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
