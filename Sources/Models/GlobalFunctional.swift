//
//  GlobalFunctional.swift
//  ReccostApp
//
//  Created by And Nik on 13.01.23.
//

import Foundation
import UIKit
import AVFoundation

class GlobalFunctional
{
    static func soundAndVibrationObserver()
    {
        if SettingsHandler.shared.isSoundOn
        {
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource:SettingsHandler.shared.appTapSoundName,ofType:"wav")!))
                audioPlayer?.play()
            }
            catch{}
        }
        if SettingsHandler.shared.isVibrationOn
        {
            GlobalFunctional.vibrateTapFeedback()
        }
    }
    
    static func vibrateTapFeedback()
    {
        let tapFeedback = UISelectionFeedbackGenerator()
        tapFeedback.prepare()
        tapFeedback.selectionChanged()
    }
    
    static func errorVibrateFeedback()
    {
        let tapFeedback = UINotificationFeedbackGenerator()
        tapFeedback.prepare()
        tapFeedback.notificationOccurred(.error)
    }
    
    static func drawLine(rect: CGRect, color: UIColor) -> UIView
    {
        let line = UIView()
        line.frame = rect
        line.layer.borderColor = color.cgColor
        line.layer.borderWidth = 1
        
        return line
    }
    
    static func isExistInArrayFromCategoryContentClass(category: CategoryContent, categories: [CategoryContent]) -> Bool
    {
        for categoryInCategories in categories where categoryInCategories.getName() == category.getName()
        {
            return true
        }
        return false
    }
    
    static func addBlurEffect(bounds: CGRect) -> UIVisualEffectView
    {
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffect.frame = bounds
        visualEffect.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        return visualEffect
    }
    
    static func addGradient(bounds: CGRect, colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        return gradientLayer
    }

    static func getFormatedPriceInString(price: Double) -> String
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2//200 -> 200.00
        formatter.numberStyle = .decimal
        
        return formatter.string(from: price as NSNumber)!
    }
    
    static func isStringAnDouble(string:String) -> Bool
    {
        return Double(string) != nil
    }
    
    static func createAllertWhith(titel: String, description: String, buttonTitel: String) -> UIAlertController
    {
        let alert = UIAlertController(title: titel, message: description, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitel, style: .default)
        
        alert.addAction(alertButton)
        return alert
    }
    
    static func getStringMonthInYer(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM y"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
    
    static func getStringDay(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
}
