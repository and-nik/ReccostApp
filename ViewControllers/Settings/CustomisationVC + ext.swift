//
//  File.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit

//MARK: - Customization View Controller

extension CustomizationViewController : AppColorsCellDelegate
{
    func reloadColor()
    {
        //self.viewDidLoad()
        self.viewWillAppear(true)
    }
}

class CustomizationViewController : UIViewController
{
    let customizationTableView = UITableView(frame: .zero, style: .insetGrouped)
    func customizationTableViewConfig()
    {
        self.customizationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.customizationTableView.backgroundColor = .clear//.systemBackground
        
        self.customizationTableView.delegate = self
        self.customizationTableView.dataSource = self
        
        self.customizationTableView.register(AppColorsCell.self, forCellReuseIdentifier: AppColorsCell.reuseID)
        
        self.view.addSubview(self.customizationTableView)
        
        self.customizationTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.customizationTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.customizationTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.customizationTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = appBackgroundColor
        
        self.customizationTableViewConfig()
        
        self.navigationItem.title = "Customization"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.tintColor = appTintColor
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = appTintColor
    }
}

extension CustomizationViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0: return "APPLICATION SYSTEM COLOR"
        default: return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        switch section
        {
        case 0: return "Select the color from the list to be used in the application."
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.customizationTableView.dequeueReusableCell(withIdentifier: AppColorsCell.reuseID, for: indexPath) as! AppColorsCell
        cell.delegate = self
        return cell
    }
}



protocol AppColorsCellDelegate
{
    func reloadColor()
}

class AppColorsCell : UITableViewCell
{
    var selectedIndex = IndexPath()
    
    var delegate: AppColorsCellDelegate?
    
    static let reuseID = "AppColorsCell"
    
    var appColorsArray = [UIColor.systemBlue, UIColor.systemGreen, UIColor.systemYellow, UIColor.systemRed, UIColor.MClightPink, UIColor.systemMint, UIColor.systemOrange, UIColor.systemCyan, UIColor.systemIndigo, UIColor.systemPurple]
    
    let appColorsColectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    func appColorsColectionViewConfig()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        self.appColorsColectionView.collectionViewLayout = layout
        
        self.appColorsColectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.appColorsColectionView.backgroundColor = .clear
        
        self.appColorsColectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        self.appColorsColectionView.delegate = self
        self.appColorsColectionView.dataSource = self
        
        self.appColorsColectionView.register(AppColorsColectionViewCell.self, forCellWithReuseIdentifier: AppColorsColectionViewCell.reuseID)
        
        self.contentView.addSubview(self.appColorsColectionView)
        
        self.appColorsColectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.appColorsColectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.appColorsColectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.appColorsColectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.tintColor = appTintColor
        self.backgroundColor = appCellBackgroundColor
        
        self.appColorsColectionViewConfig()
        
        for index in self.appColorsArray.indices
        {
            if self.appColorsArray[index] == appTintColor
            {
                self.selectedIndex = IndexPath(row: index, section: 0)
                self.appColorsColectionView.selectItem(at: self.selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppColorsCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.appColorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = self.appColorsColectionView.dequeueReusableCell(withReuseIdentifier: AppColorsColectionViewCell.reuseID, for: indexPath) as! AppColorsColectionViewCell
        cell.cellConfig(color: self.appColorsArray[indexPath.row])
        
        if self.selectedIndex == indexPath
        {
            cell.colorView.layer.borderColor = UIColor.label.cgColor
            cell.colorView.layer.borderWidth = 5
        }
        else
        {
            cell.colorView.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        appTintColor = self.appColorsArray[indexPath.item]
        self.delegate?.reloadColor()
        self.selectedIndex = indexPath
        self.appColorsColectionView.selectItem(at: self.selectedIndex, animated: true, scrollPosition: .centeredHorizontally)
        self.appColorsColectionView.reloadData()
    }
}


class AppColorsColectionViewCell : UICollectionViewCell
{
    static let reuseID = "AppColorsColectionViewCell"
    
    let colorView = UIView()
    func colorViewConfig()
    {
        self.colorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.colorView.layer.cornerRadius = self.bounds.height/2
        
        self.contentView.addSubview(self.colorView)
        
        self.colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.colorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.colorViewConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(color: UIColor)
    {
        self.colorView.backgroundColor = color
    }
}
