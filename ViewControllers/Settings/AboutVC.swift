//
//  AboutVC.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit

//MARK: - About View Controller

class AboutViewController : UIViewController
{
    private let scrollView = UIScrollView()
    private func scrollViewConfig()
    {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.scrollView)
        
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        self.view.layoutIfNeeded()
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: self.scrollView.bounds.height + 1)
    }
    
    private let appIconImageView = UIImageView()
    private func appIconImageViewConfig()
    {
        self.appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.appIconImageView)
        
        NSLayoutConstraint.activate([
            self.appIconImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.appIconImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30),
            self.appIconImageView.heightAnchor.constraint(equalToConstant: 200),
            self.appIconImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        self.appIconImageView.image = UIImage(named: "appIcon")
        self.appIconImageView.contentMode = .scaleAspectFill
    }
    
    private let appNameLabel = UILabel()
    private func appNameLabelConfig()
    {
        self.appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.appNameLabel)
        
        NSLayoutConstraint.activate([
            self.appNameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.appNameLabel.topAnchor.constraint(equalTo: self.appIconImageView.bottomAnchor, constant: 20),
            self.appNameLabel.heightAnchor.constraint(equalToConstant: 30),
            self.appNameLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        self.appNameLabel.text = "Reccost App"
        self.appNameLabel.textColor = .secondaryLabel
        self.appNameLabel.font = .boldSystemFont(ofSize: 25)
        self.appNameLabel.textAlignment = .center
    }
    
    private let descriptionTextView = UITextView()
    private func descriptionTextViewConfig()
    {
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.descriptionTextView)
        
        NSLayoutConstraint.activate([
            self.descriptionTextView.topAnchor.constraint(equalTo: self.appNameLabel.bottomAnchor, constant: 20),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20),
            self.descriptionTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        //self.descriptionTextView.sizeToFit()
        self.descriptionTextView.text = "Description: This app is text project for my githab"
        self.descriptionTextView.backgroundColor = .green
        self.descriptionTextView.font = .systemFont(ofSize: 16)
        self.descriptionTextView.textColor = .secondaryLabel
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = appBackgroundColor
        self.navigationItem.title = "About Application"
        
        self.scrollViewConfig()
        self.appIconImageViewConfig()
        self.appNameLabelConfig()
        //self.descriptionTextViewConfig()
    }
}


