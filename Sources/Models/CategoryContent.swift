//
//  CategoryContent.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class CategoryContent : Codable
{
    private var name:String
    private var imageData:Data
    var history:[EventData] = []
    var totalPrice:Double?
    {
        get
        {
            var sum = 0.0
            for element in history{sum += element.price}
            return round(100*sum)/100
        }
    }
    
    init(name:String, image:UIImage, event:EventData)
    {
        self.name = name
        self.imageData = image.pngData()!
        self.history.append(event)
    }
    
    init(name:String, image:UIImage)
    {
        self.name = name
        self.imageData = image.pngData()!
    }
    
    func setImage(image:UIImage){self.imageData = image.pngData()!}
    
    func getImage() -> UIImage
    {
        let img = UIImage(data: imageData)
        return img!
    }
    
    func getName() ->String {return self.name}
    func setName(name:String){self.name = name}
    
    func appendToHistory(event:EventData){self.history.append(event)}
    func removeFromHistory(index:Int){self.history.remove(at: index)}
    
}
