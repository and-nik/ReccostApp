//
//  LanguageVC + ext.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit

//MARK: - Currency View Controller

class CurrencyViewController : UIViewController
{
    var selectedIndex = IndexPath()
    
    var currencyArray = [String]()
    
    var delegate : SettingsViewControllerDelegate?
    
    let currencyTableView = UITableView(frame: .zero, style: .insetGrouped)
    func currencyTableViewConfig()
    {
        self.currencyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.currencyTableView.backgroundColor = .clear//.systemBackground
        
        self.currencyTableView.delegate = self
        self.currencyTableView.dataSource = self
        
        self.currencyTableView.register(DefaultCheckmarkTableViewCell.self, forCellReuseIdentifier: DefaultCheckmarkTableViewCell.reuseID)
        
        self.view.addSubview(self.currencyTableView)
        
        self.currencyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.currencyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.currencyTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.currencyTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        if self.currencyArray.isEmpty
//        {
//            self.currencyArray = ["$", "€", "₽", "¥", "р", "£"]
//            DataHandler.shared.saveCurrencyArray(newArray: self.currencyArray)
//        }
//        else
//        {
//            self.currencyArray = DataHandler.shared.loadCurrencyArray()
//        }
        self.currencyArray = DataHandler.shared.loadCurrencyArray()
        
        self.view.backgroundColor = appBackgroundColor
        
        self.currencyTableViewConfig()
        
        self.navigationItem.title = "Currency"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.tintColor = appTintColor
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(handleAdd)),
                                                   UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(handleInfo))]
        
        for index in self.currencyArray.indices
        {
            if self.currencyArray[index] == SettingsHandler.shared.moneySymbol
            {
                self.selectedIndex = IndexPath(row: index, section: 0)
            }
        }
    }
    
    @objc func handleAdd()
    {
        let alert = UIAlertController(title: "Add Currency", message: "Enter name of your currency.", preferredStyle: .alert)
        alert.addTextField
        {
            (textField : UITextField!) -> Void in
            textField.placeholder = "Currency"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {_ in
            guard let currency = alert.textFields?[0].text else {return}
            if currency == ""
            {
                self.present(GlobalFunctional.createAllertWhith(titel: "Oups...", description: "Must enter some text. Try again.", buttonTitel: "Ok"), animated: true)
            }
            else
            {
                self.currencyArray.append(currency)
                DataHandler.shared.saveCurrencyArray(newArray: self.currencyArray)
                let indexPath = IndexPath(row: self.currencyArray.count-1, section: 0)
                self.currencyTableView.insertRows(at: [indexPath], with: .top)
            }
        }))
        self.present(alert, animated: true)
    }
    
    @objc func handleInfo()
    {
        self.present(GlobalFunctional.createAllertWhith(titel: "Info", description: "Drag and drop from left to right to delete some category.", buttonTitel: "Ok"), animated: true)
    }
}

extension CurrencyViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "CURRENCY IN APP"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        return "Select the currency from the list to be used in the application ore add your new own."
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.currencyTableView.dequeueReusableCell(withIdentifier: DefaultCheckmarkTableViewCell.reuseID) as! DefaultCheckmarkTableViewCell
        cell.cellConfig(text: currencyArray[indexPath.row])
        
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
        SettingsHandler.shared.moneySymbol = self.currencyArray[indexPath.row]
        self.selectedIndex = indexPath
        self.currencyTableView.reloadData()
        self.delegate?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            self.currencyArray.remove(at: indexPath.row)
            DataHandler.shared.saveCurrencyArray(newArray: self.currencyArray)
            self.currencyTableView.deleteRows(at: [indexPath], with: .none)
        }
    }
}
