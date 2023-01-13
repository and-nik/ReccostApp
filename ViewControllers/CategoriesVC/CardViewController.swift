//
//  CardViewController.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit
import AVFoundation

class CardViewController : UIViewController
{
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
