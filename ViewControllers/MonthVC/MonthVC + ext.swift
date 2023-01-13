//
//  ViewController.swift
//  ReccostApp
//
//  Created by And Nik on 11.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox

//MARK: - Protocols

protocol ReloadDataDelegate
{
    func reloadViewController()
    func popBackViewController()
}

//MARK: - Protocol to reload all data in view controller extansion

extension MonthViewController : ReloadDataDelegate
{
    func reloadViewController()
    {
        self.reloadMainData()
    }
    func popBackViewController()
    {
        //reload collection view in users view controller
        navigationController?.popToRootViewController(animated: true)
        delegateeee?.reloadViewController()
    }
}

//MARK: - Main view controller

class MonthViewController: UIViewController
{
    var delegateeee: ReloadDataDelegate?
    
    let headerView = UIView()
    func headerViewConfig()
    {
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerView.backgroundColor = appCellBackgroundColor
        
        self.view.addSubview(self.headerView)
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        self.headerView.layoutIfNeeded()
        
        self.headerView.addSubview(GlobalFunctional.drawLine(rect: CGRect(x: 0, y: self.headerView.frame.height, width: self.headerView.frame.width, height: 1), color: .systemGray5))
    }
    
    let headerImage = UIImageView()
    private func headerImageConfig()
    {
        self.headerImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.height, height: 300)
        
        self.headerImage.image = UIImage(named: "backg_7_r")
        self.headerImage.contentMode = .scaleAspectFill
        
        self.headerImage.isUserInteractionEnabled = true
        
        self.headerImage.clipsToBounds = true
        
        self.view.addSubview(headerImage)
    }
    
    let popupPriceTextLabel = UILabel()
    private func popupPriceTextLabelCongif()
    {
        self.popupPriceTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.popupPriceTextLabel.frame = CGRect(x: 40, y: 80, width: 334, height: 30)
        self.popupPriceTextLabel.textColor = .white
        self.popupPriceTextLabel.font = .systemFont(ofSize: 16)
        self.popupPriceTextLabel.textAlignment = .center
        
        self.headerImage.addSubview(self.popupPriceTextLabel)
        
        self.popupPriceTextLabel.leftAnchor.constraint(equalTo: self.headerImage.leftAnchor, constant: 20).isActive = true
        self.popupPriceTextLabel.rightAnchor.constraint(equalTo: self.headerImage.rightAnchor, constant: -20).isActive = true
        self.popupPriceTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.popupPriceTextLabel.topAnchor.constraint(equalTo: self.headerImage.topAnchor, constant: 88).isActive = true
    }
    
    let pricePerMonthTextLabel = UILabel()
    private func pricePerMonthTextLabelCongif()
    {
        self.pricePerMonthTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.pricePerMonthTextLabel.text = "Total bills for \(usersMonths[selectedMonthIndex].getFullNameOfMonth())"
        self.pricePerMonthTextLabel.frame = CGRect(x: 40, y: 93+20, width: 334, height: 30)
        self.pricePerMonthTextLabel.textColor = .white
        self.pricePerMonthTextLabel.font = .boldSystemFont(ofSize: 20)
        self.pricePerMonthTextLabel.textAlignment = .center
        
        self.headerImage.addSubview(self.pricePerMonthTextLabel)
        
        self.pricePerMonthTextLabel.leftAnchor.constraint(equalTo: self.headerImage.leftAnchor, constant: 20).isActive = true
        self.pricePerMonthTextLabel.rightAnchor.constraint(equalTo: self.headerImage.rightAnchor, constant: -20).isActive = true
        self.pricePerMonthTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.pricePerMonthTextLabel.topAnchor.constraint(equalTo: self.headerImage.topAnchor, constant: 93+20).isActive = true
    }
    
    let pricePerMonthLabel = UILabel()
    private func pricePerMonthLabelCongif()
    {
        self.pricePerMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.pricePerMonthLabel.font = .boldSystemFont(ofSize: 18)
        self.pricePerMonthLabel.textAlignment = .left
        
        self.headerView.addSubview(self.pricePerMonthLabel)
        
        self.pricePerMonthLabel.leftAnchor.constraint(equalTo: self.headerView.leftAnchor, constant: 20).isActive = true
        self.pricePerMonthLabel.rightAnchor.constraint(equalTo: self.headerView.rightAnchor).isActive = true
        self.pricePerMonthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pricePerMonthLabel.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -45).isActive = true
    }
    
    
    let pricePerDayTextLabel = UILabel()
    private func pricePerDayTextLabelCongif()
    {
        self.pricePerDayTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.pricePerDayTextLabel.text = "Total bills per day:"
        self.pricePerDayTextLabel.frame = CGRect(x: 40, y: 300, width: 334, height: 30)
        self.pricePerDayTextLabel.textColor = .white
        self.pricePerDayTextLabel.font = .boldSystemFont(ofSize: 16)
        self.pricePerDayTextLabel.textAlignment = .center
        
        self.headerImage.addSubview(self.pricePerDayTextLabel)
        
        self.pricePerDayTextLabel.leftAnchor.constraint(equalTo: self.headerImage.leftAnchor, constant: 20).isActive = true
        self.pricePerDayTextLabel.rightAnchor.constraint(equalTo: self.headerImage.rightAnchor, constant: -20).isActive = true
        self.pricePerDayTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.pricePerDayTextLabel.topAnchor.constraint(equalTo: self.headerImage.topAnchor, constant: 300).isActive = true
    }
    
    let pricePerDayLabel = UILabel()
    private func pricePerDayLabelCongif()
    {
        self.pricePerDayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.pricePerDayLabel.font = .systemFont(ofSize: 16)
        self.pricePerDayLabel.textAlignment = .left
        
        self.headerView.addSubview(self.pricePerDayLabel)
        
        self.pricePerDayLabel.leftAnchor.constraint(equalTo: self.headerView.leftAnchor, constant: 20).isActive = true
        self.pricePerDayLabel.rightAnchor.constraint(equalTo: self.headerView.rightAnchor).isActive = true
        self.pricePerDayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pricePerDayLabel.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -23).isActive = true
    }
    
    
    let daysCollectionView = DaysCollectionView()
    func daysCollectionViewConfig()
    {
        self.daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.daysCollectionView.daysCollectionViewDelegate = self // ------ [DELEGATE INITIALISATION RELISED] --------
        
        self.headerView.addSubview(daysCollectionView)
        
        NSLayoutConstraint.activate([
            self.daysCollectionView.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.daysCollectionView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor),
            self.daysCollectionView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor),
            self.daysCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    let categoriesTableView = UITableView()
    func categoriesTableViewConfig()
    {
        self.categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoriesTableView.separatorStyle = .none
        
        self.categoriesTableView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)

        self.categoriesTableView.backgroundColor = appBackgroundColor
        
        self.categoriesTableView.register(DaysCategoriesTableViewCell.self, forCellReuseIdentifier: DaysCategoriesTableViewCell.reuseID)//can not do this in class CategoriesTableView
        
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        
        self.view.addSubview(self.categoriesTableView)

        self.categoriesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.categoriesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.categoriesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true//space between headerImage and table view
        self.categoriesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = appCellBackgroundColor
        
        self.categoriesTableViewConfig()
        self.headerViewConfig()
        self.pricePerMonthLabelCongif()
        self.daysCollectionViewConfig()
        self.pricePerDayLabelCongif()
        
        self.navigationController?.navigationBar.tintColor = appTintColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
 
        self.reloadMainData()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.daysCollectionView.selectItem(at: self.daysCollectionView.selectedIndex, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func reloadMainData()
    {
        self.pricePerMonthLabel.text = "Month: " + "\(GlobalFunctional.getFormatedPriceInString(price: usersMonths[selectedMonthIndex].totalPrice!)) \(SettingsHandler.shared.moneySymbol)"
        self.pricePerDayLabel.text = "Day: " + "\(GlobalFunctional.getFormatedPriceInString(price: usersMonths[selectedMonthIndex].days[selectedDayIndex].totalPrice!)) \(SettingsHandler.shared.moneySymbol)"
        self.categoriesTableView.reloadData()
        self.daysCollectionView.reloadData()
        self.navigationItem.title = usersMonths[selectedMonthIndex].getFullNameOfMonth()
    }
    
}


//MARK: - Extension View Contriller table view

extension MonthViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: DaysCategoriesTableViewCell.reuseID, for: indexPath) as! DaysCategoriesTableViewCell
        cell.cellConfig(category: usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[indexPath.row])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.categoriesTableView.deselectRow(at: indexPath, animated: true)//исчезание после выбора ячейки
        
        selectedCategoryIndex = indexPath.row
        
        self.categoriesTableView.reloadRows(at: [indexPath], with: .none)
        
        let localHistoryVC = LocalHisoryViewController()
        let naviLocalHistoryVC = UINavigationController(rootViewController: localHistoryVC)
        
        if let sheet = naviLocalHistoryVC.sheetPresentationController
        {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 29
        }
        
        self.present(naviLocalHistoryVC, animated: true)
        
        localHistoryVC.localHistoryDelegate = self // ------ [DELEGATE INITIALISATION RELISED] --------
    }
}
