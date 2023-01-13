//
//  UserHandler.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class UserHandler
{
    private var imageData = Data()
    private var name = String()
    private var surname = String()
    
    init(image: UIImage, name: String, surname: String)
    {
        self.imageData = image.pngData()!
        self.name = name
        self.surname = surname
    }
    
    func getImage() -> UIImage {return UIImage(data: self.imageData)!}
    func getName() -> String {return self.name}
    func getSurname() -> String {return self.surname}
    
    func setImage(image:UIImage) {self.imageData = image.pngData()!}
    func setName(name:String) {self.name = name}
    func setSurname(surname:String) {self.surname = surname}
}
