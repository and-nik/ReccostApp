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

//MARK: - Categories table view cell

class CategoriesTableViewCell : UITableViewCell
{
    var audioPlayer : AVAudioPlayer?
    
    static let reuseID = "CategoriesTableViewCell"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.frame = CGRect(x: 0, y: 0, width: 0, height: 70)
        self.infoView.backgroundColor = .none
        
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.cornerRadius = self.infoView.frame.height/7
        
        //self.infoView.addSubview(GlobalFunctional.addBlurEffect(bounds: self.infoView.bounds))
        
        self.contentView.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 35).isActive = true
    }
    
    let categoryNameLabel = UILabel()
    func categoryNameLabelConfig()
    {
        self.categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameLabel.textColor = appTitleColor
        self.categoryNameLabel.font = .systemFont(ofSize: 18)
        self.categoryNameLabel.textAlignment = .left
        
        self.infoView.addSubview(self.categoryNameLabel)
        
        self.categoryNameLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 95).isActive = true
        self.categoryNameLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.categoryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.categoryNameLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -40).isActive = true
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.infoView.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -30).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        
        self.infoViewConfig()
        
        self.iconImageViewConfig()
        self.categoryNameLabelConfig()
        self.chevronImageViewConfig()
    }

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(category: CategoryContent)
    {
        self.iconImageView.image = category.getImage()
        self.categoryNameLabel.text = category.getName()
    }
}





//MARK: - Card View Controller

class CardViewController : UIViewController
{
    var audioPlayer : AVAudioPlayer?
    
    var delegate : CellDelegate?
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appCellBackgroundColor
        
        self.view.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -370).isActive = true
        self.infoView.heightAnchor.constraint(equalToConstant: 290).isActive = true
        
        self.infoView.layoutIfNeeded()

        self.infoView.layer.cornerRadius = self.infoView.frame.height/10
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 35).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 35).isActive = true
    }
    
    let categoryNameLabel = UILabel()
    func categoryNameLabelConfig()
    {
        self.categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameLabel.textColor = appTitleColor
        self.categoryNameLabel.font = .boldSystemFont(ofSize: 26)
        self.categoryNameLabel.textAlignment = .left
        
        self.infoView.addSubview(self.categoryNameLabel)
        
        self.categoryNameLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 90).isActive = true
        self.categoryNameLabel.centerYAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 35).isActive = true
        self.categoryNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.categoryNameLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -40).isActive = true
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.chevronImageView.transform = CGAffineTransformMakeRotation(0)
        
        self.infoView.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -30).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 35).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    let textFieldsContainer = UIView()
    func textFieldsContainerConfig()
    {
        self.textFieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.textFieldsContainer.backgroundColor = appBackgroundColor
        
        self.infoView.addSubview(self.textFieldsContainer)
        
        self.textFieldsContainer.heightAnchor.constraint(equalToConstant: 135).isActive = true
        self.textFieldsContainer.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor, constant: 20).isActive = true
        self.textFieldsContainer.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor, constant: -20).isActive = true
        self.textFieldsContainer.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor,constant: 0).isActive = true
        
        self.textFieldsContainer.layoutIfNeeded()
        
        self.textFieldsContainer.layer.cornerRadius = 10
        
        self.textFieldsContainer.addSubview(GlobalFunctional.drawLine(rect: CGRect(x: 0, y: 45, width: self.textFieldsContainer.frame.width, height: 1), color: appCellBackgroundColor))
        self.textFieldsContainer.addSubview(GlobalFunctional.drawLine(rect: CGRect(x: 0, y: 90, width: self.textFieldsContainer.frame.width, height: 1), color: appCellBackgroundColor))
    }
    
    let priceTextField = UITextField()
    func priceTextFieldConfig()
    {
        self.priceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceTextField.backgroundColor = .none
        self.priceTextField.borderStyle = .none
        self.priceTextField.tintColor = appTintColor
        self.priceTextField.attributedPlaceholder = NSAttributedString(string: "Enter price \(SettingsHandler.shared.moneySymbol)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        
        self.priceTextField.becomeFirstResponder()
        
        self.textFieldsContainer.addSubview(self.priceTextField)
        
        self.priceTextField.leftAnchor.constraint(equalTo: self.textFieldsContainer.leftAnchor, constant: 10).isActive = true
        self.priceTextField.topAnchor.constraint(equalTo: self.textFieldsContainer.topAnchor, constant: 12).isActive = true
        self.priceTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.priceTextField.rightAnchor.constraint(equalTo: self.textFieldsContainer.rightAnchor, constant: -10).isActive = true
        
        self.priceTextField.addTarget(self,
                                      action: #selector(handleButton),
                                      for: .editingChanged)
    }
    
    @objc func handleButton()
    {
        if self.priceTextField.text == ""
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButton.backgroundColor = .systemGray4
                self.addButton.setTitleColor(.systemGray, for: .normal)
                self.addButton.layer.shadowRadius = 0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButton.backgroundColor = appTintColor
                self.addButton.setTitleColor(.white, for: .normal)
                
                self.addButton.layer.shadowRadius = 10
                self.addButton.layer.shadowColor = appTintColor.cgColor
                self.addButton.layer.shadowOpacity = 0.5
                self.addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            })
        }
    }
    
    let descriptionTextField = UITextField()
    func descriptionTextFieldConfig()
    {
        self.descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionTextField.backgroundColor = .none
        self.descriptionTextField.borderStyle = .none
        self.descriptionTextField.tintColor = appTintColor
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Enter description (Optional)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        
        self.infoView.addSubview(self.descriptionTextField)
        
        self.descriptionTextField.leftAnchor.constraint(equalTo: self.textFieldsContainer.leftAnchor, constant: 10).isActive = true
        self.descriptionTextField.topAnchor.constraint(equalTo: self.textFieldsContainer.topAnchor, constant: 57).isActive = true
        self.descriptionTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.descriptionTextField.rightAnchor.constraint(equalTo: self.textFieldsContainer.rightAnchor, constant: -10).isActive = true
    }
    
    let datePicker = UIDatePicker()
    func datePickerConfig()
    {
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.datePicker)
        
        self.datePicker.leftAnchor.constraint(equalTo: self.textFieldsContainer.leftAnchor, constant: 0).isActive = true
        self.datePicker.topAnchor.constraint(equalTo: self.textFieldsContainer.topAnchor, constant: 93).isActive = true
        self.datePicker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.datePicker.rightAnchor.constraint(equalTo: self.textFieldsContainer.rightAnchor, constant: -10).isActive = true
        
        self.datePicker.tintColor = appTintColor
        self.datePicker.contentMode = .left
    }
    
    let cancelButton = UIButton()
    func cancelButtonConfig()
    {
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.cancelButton)
        
        self.cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -670).isActive = true
        self.cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -90).isActive = true
        
        self.cancelButton.layoutIfNeeded()
        
        self.cancelButton.backgroundColor = appCellBackgroundColor
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height/2
        
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.setTitleColor(appTintColor, for: .normal)
        self.cancelButton.setTitleColor(.systemGray, for: .selected)
        
        self.cancelButton.addTarget(self,
                                    action: #selector(handleBack),
                                    for: .touchUpInside)
    }
    
    @objc func handleBack(sender: UIButton)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = appTintColor.cgColor
        colorAnimation.duration = 0.2
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        self.dismiss(animated: true)
    }
    
    let addButton = UIButton()
    func addButtonConfig()
    {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.addButton)
        
        self.addButton.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor, constant: 20).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor, constant: -20).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.addButton.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -20).isActive = true
        
        self.addButton.layoutIfNeeded()
        
        self.addButton.layer.cornerRadius = self.addButton.frame.height/2
        
        self.addButton.backgroundColor = .systemGray4
        
        self.addButton.setTitle("Add", for: .normal)
        self.addButton.setTitleColor(.systemGray, for: .normal)
        
        self.addButton.addTarget(self,
                                 action: #selector(handleAdd),
                                 for: .touchUpInside)
    }
    
    @objc func handleAdd()
    {
        if self.priceTextField.text == "" {return}
        
        GlobalFunctional.soundAndVibrationObserver()
        
        let nowDate = self.datePicker.date
        
        if !GlobalFunctional.isStringAnDouble(string: self.priceTextField.text!) || self.priceTextField.text == nil
        {
            if SettingsHandler.shared.isVibrationOn {GlobalFunctional.errorVibrateFeedback()}
            
            let alert = GlobalFunctional.createAllertWhith(titel: "Oups...", description: "Enter only number in price!", buttonTitel: "Ok")
            self.present(alert, animated: true)

            return
        }

        if Double(self.priceTextField.text!)! < 0
        {
            if SettingsHandler.shared.isVibrationOn {GlobalFunctional.errorVibrateFeedback()}
            
            let alert = GlobalFunctional.createAllertWhith(titel: "Oups...", description: "Price can't be a negativ number!", buttonTitel: "Ok")
            self.present(alert, animated: true)

            return
        }

        if self.descriptionTextField.text == nil
        {
            self.descriptionTextField.text = "No description"
        }
        
        let nowEventData = EventData(date: nowDate,
                                     price: Double(self.priceTextField.text!)!,
                                     description: self.descriptionTextField.text!)
        
        let nowCategory = CategoryContent(name: self.categoryNameLabel.text!,
                                          image: self.iconImageView.image!,
                                          event: nowEventData)
        
        let nowDay = DayContent(nowDate, nowCategory)
        let nowMonth = MonthContent(nowDate, nowDay)
        
        var count = 0
        for month in usersMonths where GlobalFunctional.getStringMonthInYer(nowDate) == month.getMonth()
        {
            for day in month.days where GlobalFunctional.getStringDay(nowDate) == day.getNumberOfDay()
            {
                for category in day.categorys where category.getName() == self.categoryNameLabel.text!
                {
                    category.history.insert(nowEventData, at: 0)
                    DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
                    self.delegate?.dismiss()
                    return
                }
                day.categorys.insert(nowCategory, at: 0)
                DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
                self.delegate?.dismiss()
                return
            }
            month.days.insert(nowDay, at: 0)
            count += 1
            DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
            self.delegate?.dismiss()
            return
        }
        if count == 0 {usersMonths.insert(nowMonth, at: 0) }
        DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
        self.delegate?.dismiss()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        self.cancelButtonConfig()
        
        self.infoViewConfig()
        self.iconImageViewConfig()
        self.categoryNameLabelConfig()
        self.chevronImageViewConfig()
        self.textFieldsContainerConfig()
        
        self.datePickerConfig()
        
        self.priceTextFieldConfig()
        self.descriptionTextFieldConfig()
        
        self.addButtonConfig()
        
        //self.animate()
    }
    
    func setInfo(image: UIImage, text: String)
    {
        self.iconImageView.image = image
        self.categoryNameLabel.text = text
        
        //self.animate()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.animate()
    }
    
    func animate()
    {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping:0.8,
                       initialSpringVelocity: 2,
                       options: .curveEaseOut,
                       animations: {
            
            self.cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
            self.chevronImageView.transform = CGAffineTransformMakeRotation(1.5708)
            self.view.layoutIfNeeded()

        })
    }
}





//MARK: - Card Category View Controller

protocol AddCategoryViewControllerDelegate
{
    func setImage(image: UIImage)
}

extension CardCategoryViewController: AddCategoryViewControllerDelegate
{
    func setImage(image: UIImage)
    {
        self.iconImageView.image = image
        
        if categoryNameTextField.text != ""
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButton.backgroundColor = appTintColor
                self.addButton.setTitleColor(.white, for: .normal)
                
                self.addButton.layer.shadowRadius = 10
                self.addButton.layer.shadowColor = appTintColor.cgColor
                self.addButton.layer.shadowOpacity = 0.5
                self.addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            })
        }
    }
}

class CardCategoryViewController : UIViewController
{
    var delegate : CardCategoryViewControllerDelegate? // ------ [DELEGATE INITIALISATION] --------
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appCellBackgroundColor
        
        self.view.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.infoView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -370).isActive = true
        
        self.infoView.layoutIfNeeded()
        
        self.infoView.layer.cornerRadius = 29
    }
    
    let categoryCellContainer = UIView()
    func categoryCellContainerConfig()
    {
        self.categoryCellContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryCellContainer.backgroundColor = appBackgroundColor
        
        self.infoView.addSubview(self.categoryCellContainer)
        
        self.categoryCellContainer.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 10).isActive = true
        self.categoryCellContainer.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -10).isActive = true
        self.categoryCellContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.categoryCellContainer.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 20).isActive = true
        
        self.categoryCellContainer.layoutIfNeeded()
        
        self.categoryCellContainer.layer.cornerRadius = self.categoryCellContainer.frame.height/7
    }
    
    let textFieldsContainer = UIView()
    func textFieldsContainerConfig()
    {
        self.textFieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.textFieldsContainer.backgroundColor = appCellBackgroundColor
        
        self.categoryCellContainer.addSubview(self.textFieldsContainer)
        
        self.textFieldsContainer.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.textFieldsContainer.leadingAnchor.constraint(equalTo: self.categoryCellContainer.leadingAnchor, constant: 90).isActive = true
        self.textFieldsContainer.trailingAnchor.constraint(equalTo: self.categoryCellContainer.trailingAnchor, constant: -50).isActive = true
        self.textFieldsContainer.centerYAnchor.constraint(equalTo: self.categoryCellContainer.centerYAnchor,constant: 0).isActive = true
        
        self.textFieldsContainer.layoutIfNeeded()
        
        self.textFieldsContainer.layer.cornerRadius = 10
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconImageView.image = UIImage(named: "tap")
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.categoryCellContainer.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.categoryCellContainer.topAnchor, constant: 35).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.categoryCellContainer.leftAnchor, constant: 35).isActive = true
    }
    
    let showIconsButton = UIButton()
    func showIconsButtonConfig()
    {
        self.showIconsButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryCellContainer.addSubview(self.showIconsButton)
        
        self.showIconsButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.showIconsButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.showIconsButton.centerYAnchor.constraint(equalTo: self.categoryCellContainer.topAnchor, constant: 35).isActive = true
        self.showIconsButton.leftAnchor.constraint(equalTo: self.categoryCellContainer.leftAnchor, constant: 35).isActive = true
        
        self.showIconsButton.addTarget(self,
                                       action: #selector(showIcons),
                                       for: .touchUpInside)
    }
    
    @objc func showIcons()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        let addCategoryController = AddCategoryViewController()
        self.present(UINavigationController(rootViewController: addCategoryController), animated: true)
        addCategoryController.delegate = self
    }
    
    let chevronImageView = UIImageView()
    func chevronImageViewConfig()
    {
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.chevronImageView.image = UIImage(systemName: "chevron.right")
        self.chevronImageView.contentMode = .scaleAspectFill
        self.chevronImageView.tintColor = .systemGray2
        
        self.categoryCellContainer.addSubview(self.chevronImageView)
        
        self.chevronImageView.rightAnchor.constraint(equalTo: self.categoryCellContainer.rightAnchor, constant: -30).isActive = true
        self.chevronImageView.centerYAnchor.constraint(equalTo: self.categoryCellContainer.topAnchor, constant: 35).isActive = true
        self.chevronImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.chevronImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
    }
    
    let categoryNameTextField = UITextField()
    func categoryNameTextFieldConfig()
    {
        self.categoryNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameTextField.backgroundColor = .none
        self.categoryNameTextField.borderStyle = .none
        self.categoryNameTextField.tintColor = appTintColor
        self.categoryNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter name of category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        
        self.categoryNameTextField.becomeFirstResponder()
        
        self.textFieldsContainer.addSubview(self.categoryNameTextField)
        
        self.categoryNameTextField.leftAnchor.constraint(equalTo: self.textFieldsContainer.leftAnchor, constant: 10).isActive = true
        self.categoryNameTextField.topAnchor.constraint(equalTo: self.textFieldsContainer.topAnchor, constant: 12).isActive = true
        self.categoryNameTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.categoryNameTextField.rightAnchor.constraint(equalTo: self.textFieldsContainer.rightAnchor, constant: -10).isActive = true
        
        self.categoryNameTextField.addTarget(self,
                                      action: #selector(handleButton),
                                      for: .editingChanged)
    }
    
    @objc func handleButton()
    {
        if self.categoryNameTextField.text == "" || self.iconImageView.image == UIImage(named: "tap")
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButton.backgroundColor = .systemGray4
                self.addButton.setTitleColor(.systemGray, for: .normal)
                self.addButton.layer.shadowRadius = 0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.addButton.backgroundColor = appTintColor
                self.addButton.setTitleColor(.white, for: .normal)
                
                self.addButton.layer.shadowRadius = 10
                self.addButton.layer.shadowColor = appTintColor.cgColor
                self.addButton.layer.shadowOpacity = 0.5
                self.addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            })
        }
    }
    
    let cancelButton = UIButton()
    func cancelButtonConfig()
    {
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.cancelButton)
        
        self.cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: self.infoView.topAnchor, constant: -10).isActive = true
        self.cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -90).isActive = true
        
        self.cancelButton.layoutIfNeeded()
        
        self.cancelButton.backgroundColor = appCellBackgroundColor
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height/2
        
        self.cancelButton.setTitle("Cancel", for: .normal)
        self.cancelButton.setTitleColor(appTintColor, for: .normal)
        
        self.cancelButton.addTarget(self,
                                    action: #selector(handleBack),
                                    for: .touchUpInside)
    }
    
    @objc func handleBack(sender: UIButton)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = appTintColor.cgColor
        colorAnimation.duration = 0.2
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        self.dismiss(animated: true)
    }
    
    let addButton = UIButton()
    func addButtonConfig()
    {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.addButton)
        
        self.addButton.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor, constant: 20).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor, constant: -20).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.addButton.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -20).isActive = true
        
        self.addButton.layoutIfNeeded()
        
        self.addButton.layer.cornerRadius = self.addButton.frame.height/2
        
        self.addButton.backgroundColor = .systemGray4
        
        self.addButton.setTitle("Add Category", for: .normal)
        self.addButton.setTitleColor(.systemGray, for: .normal)
        
        self.addButton.addTarget(self,
                                 action: #selector(handleAdd),
                                 for: .touchUpInside)
    }
    
    @objc func handleAdd()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        if self.categoryNameTextField.text! == ""
        {
            if SettingsHandler.shared.isVibrationOn {GlobalFunctional.errorVibrateFeedback()}
            
            self.animateView()
            let alert = GlobalFunctional.createAllertWhith(titel: "Oups...", description: "Enter name of category!", buttonTitel: "Ok")
            self.present(alert, animated: true)
            return
        }
        
        if self.iconImageView.image! == UIImage(named: "tap")
        {
            if SettingsHandler.shared.isVibrationOn {GlobalFunctional.errorVibrateFeedback()}
            
            self.animateImage()
            let alert = GlobalFunctional.createAllertWhith(titel: "Oups...", description: "Image is not choosed!\nTap on icon whith hand and choose some image", buttonTitel: "Ok")
            self.present(alert, animated: true)
            return
        }
        
        for category in allCategories where category.getName() == self.categoryNameTextField.text!
        {
            if SettingsHandler.shared.isVibrationOn {GlobalFunctional.errorVibrateFeedback()}
            
            self.animateView()
            let alert = GlobalFunctional.createAllertWhith(titel: "Oups...", description: "This category alredy exist!\nEnter other name of category", buttonTitel: "Ok")
            self.present(alert, animated: true)
            return
        }
        
        delegate?.addCaregoryToAllCategorys(image: self.iconImageView.image!, name: self.categoryNameTextField.text!) // ------ [DELEGATE RELISED] --------
        self.dismiss(animated: true)
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.infoViewConfig()
        self.categoryCellContainerConfig()
        self.iconImageViewConfig()
        self.showIconsButtonConfig()
        self.textFieldsContainerConfig()
        self.chevronImageViewConfig()
        self.categoryNameTextFieldConfig()
        
        self.cancelButtonConfig()
        
        self.addButtonConfig()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.animateView()
        self.animateImage()
        self.animate()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        delegate?.changeRightNavigationBarImage() // ------ [DELEGATE RELISED] --------
    }
    
    func animate()
    {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping:0.8,
                       initialSpringVelocity: 2,
                       options: .curveEaseOut,
                       animations: {
            
            self.cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
            self.view.layoutIfNeeded()

        })
    }
    
    func animateView()
    {
        let viewBounds = self.categoryCellContainer.bounds
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
            
            self.categoryCellContainer.bounds = CGRect(x: Int(viewBounds.origin.x),
                                          y: Int(viewBounds.origin.y),
                                          width: Int(viewBounds.width) + 40,
                                          height: Int(viewBounds.height) + 20)})
    }
    
    func animateImage()
    {
        let imageBounds = self.iconImageView.bounds
        UIView.animate(withDuration: 1.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1.5,
                       animations: {
            self.iconImageView.bounds = CGRect(x: Int(imageBounds.origin.x),
                                          y: Int(imageBounds.origin.y),
                                          width: Int(imageBounds.width) + 40,
                                          height: Int(imageBounds.height) + 20)})
    }
}
