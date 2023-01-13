//
//  CardCategoryViewController.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit
import AVFoundation

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
