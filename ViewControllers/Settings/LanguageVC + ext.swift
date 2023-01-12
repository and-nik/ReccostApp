//
//  LanguageVC + ext.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit

//MARK: - Language View Controller

class LanguageViewController : UIViewController
{
    var selectedIndex = IndexPath()
    
    var languagesArray = ["English"]
    
    var delegate : SettingsViewControllerDelegate?
    
    let languagesTableView = UITableView(frame: .zero, style: .insetGrouped)
    func languagesTableViewConfig()
    {
        self.languagesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.languagesTableView.backgroundColor = .clear//.systemBackground
        
        self.languagesTableView.delegate = self
        self.languagesTableView.dataSource = self
        
        self.languagesTableView.register(DefaultCheckmarkTableViewCell.self, forCellReuseIdentifier: DefaultCheckmarkTableViewCell.reuseID)
        
        self.view.addSubview(self.languagesTableView)
        
        self.languagesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.languagesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.languagesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.languagesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = appBackgroundColor
        
        self.languagesTableViewConfig()
        
        self.navigationItem.title = "Language"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.tintColor = appTintColor
        
        for index in self.languagesArray.indices
        {
            if self.languagesArray[index] == SettingsHandler.shared.appLanguage
            {
                self.selectedIndex = IndexPath(row: index, section: 0)
            }
        }
    }
}

extension LanguageViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        return "Select the language from the list to be used in the application."
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.languagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.languagesTableView.dequeueReusableCell(withIdentifier: DefaultCheckmarkTableViewCell.reuseID) as! DefaultCheckmarkTableViewCell
        cell.cellConfig(text: languagesArray[indexPath.row])
        
        if self.selectedIndex == indexPath
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        SettingsHandler.shared.appLanguage = self.languagesArray[indexPath.row]
        self.selectedIndex = indexPath
        self.languagesTableView.reloadData()
        self.delegate?.reloadData()
    }
}
