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
