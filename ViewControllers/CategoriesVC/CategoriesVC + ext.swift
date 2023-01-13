//
//  AddCategoriesViewController.swift
//  ReccostApp
//
//  Created by And Nik on 12.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox


//MARK: - Protocols

protocol CellDelegate
{
    func dismiss()
    func showAllert(alert: UIAlertController)
}

protocol CardCategoryViewControllerDelegate
{
    func addCaregoryToAllCategorys(image: UIImage, name: String)
    func changeRightNavigationBarImage()
}

//MARK: - Protocol extension

extension CategoriesViewController: CellDelegate
{
    func dismiss()
    {
        self.dismiss(animated: true)
        self.allCategoriesDelegate?.reloadViewController() // ------ [DELEGATE RELISED] --------
    }
    
    func showAllert(alert: UIAlertController)
    {
        self.present(alert, animated: true)
    }
}

extension CategoriesViewController: CardCategoryViewControllerDelegate
{
    func addCaregoryToAllCategorys(image: UIImage, name: String)
    {
        let event = CategoryContent(name: name, image: image)
        allCategories.insert(event, at: 0)
        
        self.categoriesTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
        self.categoriesTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        
        self.selectedIndex = IndexPath(row: -1, section: -1)
        
        DataHandler.shared.setDataCategories(events: allCategories)

        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "plus.app")
    }
    
    func changeRightNavigationBarImage()
    {
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "plus.app")
    }
}

//MARK: - Categories view controller class

class CategoriesViewController: UIViewController
{
    var allCategoriesDelegate: ReloadDataDelegate? // ------ [DELEGATE INITIALISATION] --------
    
    var selectedIndex = IndexPath(row: -1, section: -1)
    var selectedState = false
    
    let searchController = UISearchController()
    func searchControllerConfig()
    {
        self.navigationItem.searchController = self.searchController
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.searchController.searchBar.tintColor = appTintColor
        self.searchController.searchBar.placeholder = "Search category "
        
        self.searchController.searchResultsUpdater = self
    }
    
    let backgroundImage = UIImageView()
    func backgroundImageConfig()
    {
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundImage.image = UIImage(named: "backg_7")
        self.backgroundImage.contentMode = .scaleAspectFill
        
        self.view.insertSubview(self.backgroundImage, at: 0)
        
        self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    let categoriesTableView = UITableView()
    func categoriesTableViewConfig()
    {
        self.categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoriesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        
        self.categoriesTableView.separatorStyle = .none
        self.categoriesTableView.backgroundColor = appCellBackgroundColor
        
        self.categoriesTableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.reuseID)

        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        
        self.view.addSubview(self.categoriesTableView)
        
        self.categoriesTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.categoriesTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.categoriesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.categoriesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var firstTimeLoadAllCategories = DataHandler.shared.loadDataCategories()
        if firstTimeLoadAllCategories.isEmpty
        {
            DataHandler.shared.setDataCategories(events: allCategories)
        }
        firstTimeLoadAllCategories.removeAll()
        
        allCategories = DataHandler.shared.loadDataCategories()
        
        //self.searchControllerConfig()
        self.categoriesTableViewConfig()
        
        self.navigationController?.navigationBar.backgroundColor = appBackgroundColor
        
        self.navigationController?.navigationBar.tintColor = appTintColor //change items color in navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationItem.title = "All Categories"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                                target: self,
                                                                action: #selector(handleBack))
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(handleAdd)),
                                                   
                                                   UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(handleInfo))]
    }
    
    @objc func handleInfo()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.present(GlobalFunctional.createAllertWhith(titel: "Info", description: "Drag and drop from left to right to delete some category", buttonTitel: "Ok"), animated: true)
    }
    
    @objc func handleBack()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleAdd()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "plus.app.fill")
        
        let cardCategoryVC = CardCategoryViewController()
        cardCategoryVC.delegate = self// ------ [DELEGATE INITIALISATION RELISED] --------
        self.present(cardCategoryVC, animated: true)
    }
    
}

extension CategoriesViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        print(searchController.searchBar.text!)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.reuseID, for: indexPath) as! CategoriesTableViewCell
        cell.cellConfig(category: allCategories[indexPath.item])
        
        cell.infoView.backgroundColor = appBackgroundColor
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.categoriesTableView.deselectRow(at: indexPath, animated: true)
        
        let cardVC = CardViewController()
        //cardVC.modalPresentationStyle = .overFullScreen
        let navCardVC = UINavigationController(rootViewController: cardVC)
        //navCardVC.modalPresentationStyle = .overFullScreen
        cardVC.setInfo(image: allCategories[indexPath.row].getImage(), text: allCategories[indexPath.row].getName())
        cardVC.delegate = self
        self.present(navCardVC, animated: true)
        
        self.selectedIndex = indexPath
        
        self.categoriesTableView.beginUpdates()
        self.categoriesTableView.reloadRows(at: [self.selectedIndex], with: .none)
        self.categoriesTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            allCategories.remove(at: indexPath.row)
            
            DataHandler.shared.setDataCategories(events: allCategories)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        self.selectedIndex = IndexPath(row: -1, section: -1)
    }
}
