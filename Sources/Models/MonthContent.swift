//
//  MonthContent.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit

class MonthContent : Codable
{
    var date:Date?
    var days:[DayContent] = []
    var totalPrice:Double?
    {
        get
        {
            var sum = 0.0
            for element in self.days{sum += element.totalPrice!}
            return round(100*sum)/100
        }
    }
    
    init(){}
    
    init(_ date: Date, _ day: DayContent)
    {
        self.date = date
        self.days.insert(day, at: 0)
    }
    
    func getMonth() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM y"
        let stringDate = formatter.string(from: self.date!)
        return stringDate
    }
    
    func getFullNameOfMonth() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM y"
        let stringDate = formatter.string(from: self.date!)
        return stringDate
    }
    
    func sortArray()
    {
        self.days.sort(by: { $0.date! < $1.date!})
    }
}
