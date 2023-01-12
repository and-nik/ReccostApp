//
//  EditVC + ext.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit

//MARK: - Edit View Controller

class EditViewController : UIViewController
{
    let editTableView = UITableView(frame: .zero, style: .insetGrouped)
    func editTableViewConfig()
    {
        self.editTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.editTableView.backgroundColor = .clear//.systemBackground
        
        self.editTableView.delegate = self
        self.editTableView.dataSource = self
        
        self.editTableView.register(EditTableViewControllerCell.self, forCellReuseIdentifier: EditTableViewControllerCell.reuseID)
        
        self.view.addSubview(self.editTableView)
        
        self.editTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.editTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.editTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.editTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let tableViewHeader = UIView()
        
        tableViewHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        
        let profilImageView = UIImageView()
        
        profilImageView.translatesAutoresizingMaskIntoConstraints = false
        profilImageView.image = UIImage(named: "my")
        profilImageView.contentMode = .scaleAspectFill
        profilImageView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        profilImageView.backgroundColor = .clear
        
        profilImageView.layer.borderWidth = 5
        profilImageView.layer.borderColor = UIColor.white.cgColor
        profilImageView.layer.cornerRadius = profilImageView.frame.height/2
        profilImageView.layer.masksToBounds = true
        
        tableViewHeader.addSubview(profilImageView)
        
        profilImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profilImageView.centerYAnchor.constraint(equalTo: tableViewHeader.centerYAnchor, constant: -25).isActive = true
        profilImageView.centerXAnchor.constraint(equalTo: tableViewHeader.centerXAnchor).isActive = true
        
        let editProfilImageButton = UIButton()

        editProfilImageButton.translatesAutoresizingMaskIntoConstraints = false
        editProfilImageButton.setTitle("Set new photo", for: .normal)
        editProfilImageButton.setTitleColor(appTintColor, for: .normal)
        editProfilImageButton.addTarget(self,
                                        action: #selector(setNewFoto),
                                        for: .touchUpInside)
        
        tableViewHeader.addSubview(editProfilImageButton)
        
        editProfilImageButton.leftAnchor.constraint(equalTo: tableViewHeader.leftAnchor, constant: 40).isActive = true
        editProfilImageButton.rightAnchor.constraint(equalTo: tableViewHeader.rightAnchor, constant: -40).isActive = true
        editProfilImageButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        editProfilImageButton.centerXAnchor.constraint(equalTo: tableViewHeader.centerXAnchor).isActive = true
        editProfilImageButton.centerYAnchor.constraint(equalTo: tableViewHeader.centerYAnchor, constant: 40).isActive = true
        
        self.editTableView.tableHeaderView = tableViewHeader
        self.editTableView.tableHeaderView?.clipsToBounds = true
    }
    
    @objc func setNewFoto()
    {
        print("dddd")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = appBackgroundColor
        
        self.editTableViewConfig()
        
        self.navigationItem.title = "Edit profil"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                 target: self,
                                                                 action: #selector(handleCancel))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(handleDone))
    }
    
    @objc func handleCancel()
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func handleDone()
    {
        self.navigationController?.popViewController(animated: false)
        
        let nameCell = self.editTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditTableViewControllerCell
        let surnameCell = self.editTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! EditTableViewControllerCell
        
        user.setName(name: nameCell.textField.text!)
        user.setSurname(surname: surnameCell.textField.text!)
        
        self.navigationController?.popViewController(animated: false)
    }
}

extension EditViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        return "Set your name and surname."
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.editTableView.dequeueReusableCell(withIdentifier: EditTableViewControllerCell.reuseID, for: indexPath) as! EditTableViewControllerCell
        
        if indexPath.row == 0
        {
            cell.cellConfig(text: user.getName())
            cell.textField.placeholder = "Name"
        }
        else
        {
            cell.cellConfig(text: user.getSurname())
            cell.textField.placeholder = "Surname"
        }
        return cell
    }
}

class EditTableViewControllerCell : UITableViewCell
{
    static let reuseID = "EditTableViewControllerCell"
    
    let textField = UITextField()
    func textFieldConfig()
    {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.textField.tintColor = appTintColor
        
        self.contentView.addSubview(self.textField)
        
        self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = appCellBackgroundColor
        
        self.textFieldConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(text: String)
    {
        self.textField.text = text
    }
}
