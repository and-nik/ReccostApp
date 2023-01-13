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
