//
//  SettingsViewController.swift
//  ReccostApp
//
//  Created by And Nik on 11.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox

//MARK: - Protocol

protocol SettingsViewControllerDelegate
{
    func reloadData()
}

extension SettingsViewController : SettingsViewControllerDelegate
{
    func reloadData()
    {
        self.settingsTableView.reloadData()
    }
}

//MARK: - Settings View Controller

class SettingsViewController: UIViewController
{
    let settingsArray = [[SettingsCell(iconImage: UIImage(systemName: "bookmark.fill")!, titel: "Favorites", backgroundColor: .systemYellow)],
                         
                         [SettingsCell(iconImage: UIImage(systemName: "circle.fill")!, titel: "Customization", backgroundColor: .systemBlue),
                          SettingsCell(iconImage: UIImage(systemName: "dollarsign.circle.fill")!, titel: "Currency", backgroundColor: .systemOrange),
                          SettingsCell(iconImage: UIImage(systemName: "globe")!, titel: "Language", backgroundColor: .systemPurple),
                          SettingsCell(iconImage: UIImage(systemName: "speaker.wave.2.fill")!, titel: "Sound and vibration", backgroundColor: .systemRed)],
                         
                         [SettingsCell(iconImage: UIImage(systemName: "info.circle.fill")!, titel: "About Application", backgroundColor: .systemCyan)]]
    
    let tableViewHeader = UIView()
    let profilImageView = UIImageView()
    let profilNameLabel = UILabel()
    
    let settingsTableView = UITableView(frame: .zero, style: .insetGrouped)
    func settingsTableViewConfig()
    {
        self.settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.settingsTableView.backgroundColor = appBackgroundColor
        
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self

        self.settingsTableView.register(SettingsViewControllerDefaultCell.self, forCellReuseIdentifier: SettingsViewControllerDefaultCell.reuseID)
        
        self.view.addSubview(self.settingsTableView)
        
        self.settingsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.settingsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.settingsTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.settingsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.settingsTableView.tableHeaderView = tableViewHeader
        
        tableViewHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        
        profilImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profilImageView.contentMode = .scaleAspectFill
        profilImageView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        profilImageView.backgroundColor = .clear
        
        profilImageView.layer.borderWidth = 5
        profilImageView.layer.cornerRadius = profilImageView.frame.height/2
        profilImageView.layer.masksToBounds = true
        
        tableViewHeader.addSubview(profilImageView)
        
        profilImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profilImageView.centerYAnchor.constraint(equalTo: tableViewHeader.centerYAnchor, constant: -25).isActive = true
        profilImageView.centerXAnchor.constraint(equalTo: tableViewHeader.centerXAnchor).isActive = true
        
        profilNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profilNameLabel.font = .boldSystemFont(ofSize: 18)
        profilNameLabel.textColor = appTitleColor
        profilNameLabel.textAlignment = .center
        
        tableViewHeader.addSubview(self.profilNameLabel)
        
        self.profilNameLabel.rightAnchor.constraint(equalTo: tableViewHeader.rightAnchor, constant: -40).isActive = true
        self.profilNameLabel.leftAnchor.constraint(equalTo: tableViewHeader.leftAnchor, constant: 40).isActive = true
        self.profilNameLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        profilNameLabel.centerXAnchor.constraint(equalTo: tableViewHeader.centerXAnchor).isActive = true
        self.profilNameLabel.centerYAnchor.constraint(equalTo: tableViewHeader.centerYAnchor, constant: 45).isActive = true
        
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .MCBackg_2_r//.systemGroupedBackground
        
        self.settingsTableViewConfig()
        
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                 target: self,
                                                                 action: #selector(handleEdit))
    }
    
    @objc func handleEdit()
    {
        let editVC = EditViewController()
        self.navigationController?.pushViewController(editVC, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = appTintColor
        self.profilImageView.image = UIImage(named: "my")
        self.profilImageView.layer.borderColor = appTintColor.cgColor
        self.profilNameLabel.text = "\(user.getName()) \(user.getSurname())"
        self.tabBarController?.tabBar.tintColor = appTintColor
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.settingsArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: SettingsViewControllerDefaultCell.reuseID, for: indexPath) as! SettingsViewControllerDefaultCell
        
        cell.cellConfig(image: self.settingsArray[indexPath.section][indexPath.row].iconImage,
                        name: self.settingsArray[indexPath.section][indexPath.row].titel,
                        backgroundColor: settingsArray[indexPath.section][indexPath.row].backgroundColor)
        
        switch indexPath
        {
        case IndexPath(row: 0, section: 0): cell.cellDescription(description: "Later...")
        case IndexPath(row: 1, section: 1): cell.cellDescription(description: SettingsHandler.shared.moneySymbol)
        case IndexPath(row: 2, section: 1): cell.cellDescription(description: SettingsHandler.shared.appLanguage)
        default: cell.cellDescription(description: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.settingsTableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath
        {
        case IndexPath(row: 0, section: 1):
            let viewVC = CustomizationViewController()
            viewVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewVC, animated: true)
            
        case IndexPath(row: 1, section: 1):
            let currVC = CurrencyViewController()
            currVC.hidesBottomBarWhenPushed = true
            currVC.delegate = self
            self.navigationController?.pushViewController(currVC, animated: true)
            
        case IndexPath(row: 2, section: 1):
            let lanVC = LanguageViewController()
            lanVC.hidesBottomBarWhenPushed = true
            lanVC.delegate = self
            self.navigationController?.pushViewController(lanVC, animated: true)
            
        case IndexPath(row: 3, section: 1):
            let soundAndVibroVC = SoundAndVibroViewController()
            soundAndVibroVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(soundAndVibroVC, animated: true)
            
        case IndexPath(row: 0, section: 2):
            let aboutVC = AboutViewController()
            aboutVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(aboutVC, animated: true)
        default: return
        }
    }

}
