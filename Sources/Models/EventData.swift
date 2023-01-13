//
//  EventData.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

struct EventData : Codable
{
    var date:Date
    var price:Double
    var description:String
    var dateMonth:String?
    
    func getStringDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.y HH:mm"
        let stringDate = formatter.string(from: self.date)
        return stringDate
    }
    
    func getStringDateMonth() -> String
    {
        let separatedDate:[String] = self.getStringDate().components(separatedBy: " ")
        return separatedDate[0]
    }
    
    func getDate() ->Date {return self.date}
    func getPrice() ->Double {return round(100*self.price)/100}
    func getDescription() ->String {return self.description}
}
