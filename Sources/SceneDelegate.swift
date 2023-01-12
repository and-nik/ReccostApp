//
//  SceneDelegate.swift
//  ReccostApp
//
//  Created by And Nik on 11.09.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
        
        let tabBarVC = TabBarViewController()
        self.window?.rootViewController = tabBarVC
        
    }

}
