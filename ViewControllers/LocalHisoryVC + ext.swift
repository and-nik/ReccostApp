//
//  LocalHisoryCellViewController.swift
//  ReccostApp
//
//  Created by And Nik on 12.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox

//MARK: - Main controller

class LocalHisoryViewController: UIViewController
{
    var selectedIndex = IndexPath(row: -1, section: -1)
    
    var localHistoryDelegate: ReloadDataDelegate? // ------ [DELEGATE INITIALISATION] --------
    
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
    
    let localHistoryTableView = UITableView()
    func localHistoryTableViewConfig()
    {
        self.localHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.localHistoryTableView.separatorStyle = .none
        self.localHistoryTableView.backgroundColor = .none
        
        self.localHistoryTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        self.localHistoryTableView.delegate = self
        self.localHistoryTableView.dataSource = self
        
        self.localHistoryTableView.register(LocalHistoryTableViewCell.self, forCellReuseIdentifier: LocalHistoryTableViewCell.reuseID)
        
        self.view.addSubview(self.localHistoryTableView)
        
        self.localHistoryTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.localHistoryTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.localHistoryTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.localHistoryTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = appCellBackgroundColor
        //self.backgroundImageConfig()
        self.localHistoryTableViewConfig()
        
        self.navigationController?.navigationBar.tintColor = appTintColor
        self.navigationController?.navigationBar.backgroundColor = appBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor] //chenge title color in navigation bar
        self.navigationItem.title = "\(usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex].getName()) History"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                                 target: self,
                                                                 action: #selector(handleBack))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(handleInfo))
    }
    
    @objc func handleInfo()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.present(GlobalFunctional.createAllertWhith(titel: "Info", description: "Drag and drop from left to right to delete some history", buttonTitel: "Ok"), animated: true)
    }
    
    @objc func handleBack()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LocalHisoryViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex].history.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = localHistoryTableView.dequeueReusableCell(withIdentifier: LocalHistoryTableViewCell.reuseID) as! LocalHistoryTableViewCell
        
        cell.cellConfig(category: usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex],
                        eventData: usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex].history[indexPath.row])
        
        //cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        localHistoryTableView.deselectRow(at: indexPath, animated: true)//исчезание после выбора ячейки
        print("ip - ", indexPath.item)
        self.selectedIndex = indexPath
        
        //self.localHistoryTableView.beginUpdates()
        self.localHistoryTableView.reloadRows(at: [self.selectedIndex], with: .none)
        //self.localHistoryTableView.endUpdates()
    }
    
    //delete cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex].history.remove(at: indexPath.row)
            //tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.endUpdates()
            DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
        }
        if usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys[selectedCategoryIndex].totalPrice == 0
        {
            usersMonths[selectedMonthIndex].days[selectedDayIndex].categorys.remove(at: selectedCategoryIndex)
            DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
        }
        if usersMonths[selectedMonthIndex].days[selectedDayIndex].totalPrice == 0
        {
            usersMonths[selectedMonthIndex].days.remove(at: selectedDayIndex)
            DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
        }
        if usersMonths[selectedMonthIndex].totalPrice == 0
        {
            usersMonths.remove(at: selectedMonthIndex)
            
            selectedMonthIndex = 0
            
            self.dismiss(animated: true, completion: nil)
            localHistoryDelegate?.reloadViewController()// ------ [DELEGATE RELISED] --------
            localHistoryDelegate?.popBackViewController()// ------ [DELEGATE RELISED] --------
            DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
            return
        }
        self.dismiss(animated: true, completion: nil)
        localHistoryDelegate?.reloadViewController()// ------ [DELEGATE RELISED] --------
        DataHandler.shared.saveUsersMonthArray(newArray: usersMonths)// --------   [USER DEFAULTS SAVE DATA]   ---------
    }
    
}





//MARK: - History table view cell

class LocalHistoryTableViewCell : UITableViewCell
{
    static let reuseID = "HistoryTableViewCell"
    
    let infoView = UIView()
    func infoViewConfig()
    {
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.backgroundColor = appBackgroundColor
        
        self.contentView.addSubview(self.infoView)
        
        self.infoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.infoView.layoutIfNeeded()
        self.infoView.layer.cornerRadius = 29
        
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.2
    }
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.infoView.addSubview(self.iconImageView)
        
        self.iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
        self.iconImageView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 20).isActive = true
        
        self.iconImageView.layer.cornerRadius = 2
    }
    
    let categoryNameLabel = UILabel()
    func categoryNameLabelConfig()
    {
        self.categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryNameLabel.textColor = appTitleColor
        self.categoryNameLabel.font = .systemFont(ofSize: 18)
        self.categoryNameLabel.textAlignment = .left
        
        self.infoView.addSubview(self.categoryNameLabel)
        
        self.categoryNameLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.categoryNameLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
        self.categoryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.categoryNameLabel.rightAnchor.constraint(equalTo: self.dateLabel.leftAnchor, constant: -10).isActive = true
    }
    
    let priceLabel = UILabel()
    func priceLabelConfig()
    {
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceLabel.textColor = appTintColor
        self.priceLabel.font = .boldSystemFont(ofSize: 40)
        self.priceLabel.textAlignment = .left
        
        self.infoView.addSubview(self.priceLabel)
        
        self.priceLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.priceLabel.centerYAnchor.constraint(equalTo: self.infoView.centerYAnchor).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -10).isActive = true
    }
    
    let descriptionTextView = UITextView()
    func descriptionTextViewConfig()
    {
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionTextView.backgroundColor = .none
        self.descriptionTextView.font = .systemFont(ofSize: 12)
        self.descriptionTextView.textColor = .secondaryLabel
        
        self.descriptionTextView.showsVerticalScrollIndicator = true
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.isScrollEnabled = true
        
        self.infoView.addSubview(self.descriptionTextView)
        
        self.descriptionTextView.leftAnchor.constraint(equalTo: self.infoView.leftAnchor, constant: 45).isActive = true
        self.descriptionTextView.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: -5).isActive = true
        self.descriptionTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.descriptionTextView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    let dateLabel = UILabel()
    func dateLabelConfig()
    {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLabel.textColor = .secondaryLabel
        self.dateLabel.font = .systemFont(ofSize: 18)
        self.dateLabel.textAlignment = .right
        
        self.infoView.addSubview(self.dateLabel)
        
        self.dateLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor, constant: -20).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.dateLabel.widthAnchor.constraint(equalToConstant: 145).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.infoView.topAnchor, constant: 10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.infoViewConfig()
        self.iconImageViewConfig()
        
        self.priceLabelConfig()
        self.descriptionTextViewConfig()
        self.dateLabelConfig()
        
        self.categoryNameLabelConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(category: CategoryContent, eventData: EventData)
    {
        self.iconImageView.image = category.getImage()
        self.categoryNameLabel.text = category.getName()
        self.priceLabel.text = "\(GlobalFunctional.getFormatedPriceInString(price: eventData.getPrice()))\(SettingsHandler.shared.moneySymbol)"
        if eventData.getDescription() == ""
        {
            self.descriptionTextView.text = "No description"
        }
        else
        {
            self.descriptionTextView.text = eventData.getDescription()
        }
        self.dateLabel.text = eventData.getStringDate()
    }
    
    func animate(){
        let viewBounds = self.infoView.bounds
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       usingSpringWithDamping:0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {self.contentView.layoutIfNeeded()})
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
            
            self.infoView.bounds = CGRect(x: Int(viewBounds.origin.x),
                                          y: Int(viewBounds.origin.y),
                                          width: Int(viewBounds.width) + 40,
                                          height: Int(viewBounds.height) + 20)
        })
        
        let animator = UIViewPropertyAnimator(duration: 0.5,
                                              curve: .easeIn,
                                              animations: {self.infoView.backgroundColor = .systemGray5
        })
        animator.startAnimation()
    }
    
}
