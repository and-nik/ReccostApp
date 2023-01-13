//
//  DaysCollecttionView.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DaysCollectionView : UICollectionView
{
    var selectedIndex = IndexPath(row: 0, section: 0)
    let nowDate = Date()
    
    var daysCollectionViewDelegate: ReloadDataDelegate?
    
    init()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.minimumLineSpacing = 14
        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = .clear
        
        self.register(DaysCollectionViewCell.self, forCellWithReuseIdentifier: DaysCollectionViewCell.reuseID)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        selectedDayIndex = 0
        
        var index = 0
        for day in usersMonths[selectedMonthIndex].days
        {
            if day.getNumberOfDay() == GlobalFunctional.getStringDay(nowDate)
            {
                selectedIndex = IndexPath(item: index, section: 0)
                selectedDayIndex = index
            }
            else
            {
                index += 1
            }
        }
        
    }
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Days Collection view delegate and dataSource

extension DaysCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return usersMonths[selectedMonthIndex].days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCollectionViewCell.reuseID, for: indexPath) as! DaysCollectionViewCell
        
        if usersMonths[selectedMonthIndex].days[indexPath.item].getNumberOfDay() == GlobalFunctional.getStringDay(nowDate) &&
                usersMonths[selectedMonthIndex].getMonth() == GlobalFunctional.getStringMonthInYer(nowDate)
        {
            cell.showNowDay()
        }
        else
        {
            cell.deselectedCell()
        }
        if self.selectedIndex.item == indexPath.item
        {
            cell.selectedCell()
        }
        
        cell.cellConfig(textDate: usersMonths[selectedMonthIndex].days[indexPath.item].getWeekDay() + "\n" + usersMonths[selectedMonthIndex].days[indexPath.item].getNumberOfDay())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.selectedIndex = indexPath
        
        selectedDayIndex = indexPath.item
        
        print("select ", selectedIndex.item)
        
        self.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        self.daysCollectionViewDelegate?.reloadViewController()
    }
}
