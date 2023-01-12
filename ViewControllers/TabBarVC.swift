//
//  TabBarViewController.swift
//  ReccostApp
//
//  Created by And Nik on 11.09.22.
//

import UIKit

class TabBarViewController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createTabBar()
        self.tabBarSettings()
    }
    
    private func createTabBar()
    {
        let navUserVC = UINavigationController(rootViewController: UserViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        self.viewControllers = [createVC(VC: navUserVC, title: "Profil", image: UIImage(systemName: "person.fill")!),
                                createVC(VC: settingsVC, title: "Settings", image: UIImage(systemName: "gear")!)]
    }
    
    private func createVC(VC: UINavigationController, title: String, image: UIImage) -> UINavigationController
    {
        VC.tabBarItem.title = title
        VC.tabBarItem.image = image
        
        return VC
    }
    
    private func tabBarSettings()
    {
        tabBar.tintColor = appTintColor
    }
}
