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
    
    
    let daysCollectionView = DaysCollecttionView()
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




// MARK: - Days Collection view

class DaysCollecttionView : UICollectionView
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

extension DaysCollecttionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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



//MARK: - Days Collection view cell

class DaysCollectionViewCell : UICollectionViewCell
{
    static let reuseID = "DaysCollectionViewCell"
    
    private let infoView = UIView()
    private func infoViewConfig()
    {
        self.infoView.backgroundColor = appBackgroundColor
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.cornerRadius = 10
        
        self.addSubview(self.infoView)
        
        self.infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private let dayLabel = UILabel()
    private func dayLabelConfig()
    {
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dayLabel.text = ""
        self.dayLabel.numberOfLines = 2
        self.dayLabel.font = .systemFont(ofSize: 18)
        self.dayLabel.textAlignment = .center
        
        self.infoView.addSubview(self.dayLabel)
        
        self.dayLabel.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor).isActive = true
        self.dayLabel.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor).isActive = true
        self.dayLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor).isActive = true
        self.dayLabel.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.infoViewConfig()
        self.dayLabelConfig()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func cellConfig(textDate: String)
    {
        self.dayLabel.text = textDate
    }
    
    func selectedCell()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.backgroundColor = appTintColor})
        self.dayLabel.textColor = .white
    }
    
    func deselectedCell()
    {
        self.infoView.backgroundColor = appBackgroundColor
        self.infoView.layer.borderWidth = 0
        self.dayLabel.textColor = appTitleColor
    }
    
    func showNowDay()
    {
        self.infoView.layer.borderWidth = 5
        self.infoView.layer.borderColor = appTintColor.cgColor
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



//MARK: - Category table view cell

class DaysCategoriesTableViewCell : UITableViewCell
{
    static let reuseID = "DaysCategoriesTableView"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appCellBackgroundColor
        
        self.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.1
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 30).isActive = true
    }
    
    let nameTextView = UITextView()
    func nameTextViewConfig()
    {
        self.nameTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameTextView.backgroundColor = .clear
        self.nameTextView.font = .systemFont(ofSize: 18)
        
        self.nameTextView.showsVerticalScrollIndicator = true
        self.nameTextView.isEditable = false
        self.nameTextView.isScrollEnabled = true
        
        self.infoView.addSubview(self.nameTextView)
        
        self.nameTextView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 85).isActive = true
        self.nameTextView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.nameTextView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.nameTextView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    let countOfPaymentsLabel = UILabel()
    func countOfPaymentsLabelConfig()
    {
        self.countOfPaymentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.countOfPaymentsLabel.textColor = appTintColor
        self.countOfPaymentsLabel.font = .boldSystemFont(ofSize: 20)
        self.countOfPaymentsLabel.textAlignment = .center
        
        self.infoView.addSubview(self.countOfPaymentsLabel)
        
        self.countOfPaymentsLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 195).isActive = true
        self.countOfPaymentsLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.countOfPaymentsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.countOfPaymentsLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let totalPriceLabel = UILabel()
    func totalPriceLabelConfig()
    {
        self.totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.totalPriceLabel.font = .systemFont(ofSize: 18)
        self.totalPriceLabel.textAlignment = .right
        
        self.infoView.addSubview(self.totalPriceLabel)
        
        self.totalPriceLabel.leftAnchor.constraint(equalTo: self.countOfPaymentsLabel.rightAnchor).isActive = true
        self.totalPriceLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.totalPriceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.totalPriceLabel.rightAnchor.constraint(equalTo: self.chevronImageView.leftAnchor, constant: -10).isActive = true
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.infoView.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -20).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.infoViewConfig()
        self.iconImageViewConfig()
        self.nameTextViewConfig()
        self.countOfPaymentsLabelConfig()
        self.chevronImageViewConfig()
        self.totalPriceLabelConfig()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.infoView.layer.cornerRadius = self.infoView.bounds.height/2
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        //self.animate()
    }
    
    func showSmoothCell()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.alpha = 1})
    }
    
    func cellConfig(category: CategoryContent)
    {
        self.iconImageView.image = category.getImage()
        self.nameTextView.text = category.getName()
        self.countOfPaymentsLabel.text = String(category.history.count)
        self.totalPriceLabel.text = "\(GlobalFunctional.getFormatedPriceInString(price: category.totalPrice!))\(SettingsHandler.shared.moneySymbol)"
        self.animate()
    }
    
    func animate()
    {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations:
                        {
            self.infoView.bounds = CGRect(x: Int(self.infoView.bounds.origin.x),
                                          y: Int(self.infoView.bounds.origin.y),
                                          width: Int(self.infoView.bounds.width) + 40,
                                          height: Int(self.infoView.bounds.height) + 20)})
    }
}
