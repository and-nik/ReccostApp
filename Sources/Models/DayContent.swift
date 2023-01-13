//
//  DayContent.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class DayContent : Codable
{
    var date:Date?
    var categorys:[CategoryContent] = []
    var totalPrice:Double?
    {
        get
        {
            var sum = 0.0
            for element in self.categorys{sum += element.totalPrice!}
            return round(100*sum)/100
        }
    }
    
    init(){}
    
    init(_ date: Date, _ category: CategoryContent)
    {
        self.date = date
        self.categorys.insert(category, at: 0)
    }
    
    func getNumberOfDay() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let stringDate = formatter.string(from: self.date!)
        return stringDate
    }
    
    func getWeekDay() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        let stringDate = formatter.string(from: self.date!)
        return stringDate
    }
    
}
