//
//  Model.swift
//  ReccostApp
//
//  Created by And Nik on 11.09.22.
//

import Foundation
import UIKit
import AVFoundation


//MARK: - Castomisation

var appBackgroundColor: UIColor = .systemGroupedBackground
var appCellBackgroundColor: UIColor = .secondarySystemGroupedBackground
var appTitleColor: UIColor = .label

var appTintColor: UIColor
{
    get
    {
        switch SettingsHandler.shared.appTintColorName
        {
        case ColorsKey.systemBlue: return .systemBlue
        case ColorsKey.systemGreen: return .systemGreen
        case ColorsKey.systemYellow: return .systemYellow
        case ColorsKey.systemRed: return .systemRed
        case ColorsKey.MClightPink: return .MClightPink
        case ColorsKey.systemMint: return .systemMint
        case ColorsKey.systemOrange: return .systemOrange
        case ColorsKey.systemCyan: return .systemCyan
        case ColorsKey.systemIndigo: return .systemIndigo
        case ColorsKey.systemPurple: return .systemPurple
        default: return .systemBlue
        }
    }
    set
    {
        switch newValue
        {
        case .systemBlue: SettingsHandler.shared.appTintColorName = ColorsKey.systemBlue
        case .systemGreen: SettingsHandler.shared.appTintColorName = ColorsKey.systemGreen
        case .systemYellow: SettingsHandler.shared.appTintColorName = ColorsKey.systemYellow
        case .systemRed: SettingsHandler.shared.appTintColorName = ColorsKey.systemRed
        case .MClightPink: SettingsHandler.shared.appTintColorName = ColorsKey.MClightPink
        case .systemMint: SettingsHandler.shared.appTintColorName = ColorsKey.systemMint
        case .systemOrange: SettingsHandler.shared.appTintColorName = ColorsKey.systemOrange
        case .systemCyan: SettingsHandler.shared.appTintColorName = ColorsKey.systemCyan
        case .systemIndigo: SettingsHandler.shared.appTintColorName = ColorsKey.systemIndigo
        case .systemPurple: SettingsHandler.shared.appTintColorName = ColorsKey.systemPurple
        default: break
        }
    }
}


//MARK: - Global values

var audioPlayer : AVAudioPlayer?

let user = UserHandler(image: UIImage(named: "my")!, name: "Big", surname: "Kick")

var usersMonths = [MonthContent]()
var monthCategories = [CategoryContent]()

var selectedMonthIndex = 0
var selectedDayIndex = 0
var selectedCategoryIndex = 0

var allCategories = [CategoryContent(name: "Business", image: #imageLiteral(resourceName: "icon_1")),
                     CategoryContent(name: "Sport", image: #imageLiteral(resourceName: "icon_4")),
                     CategoryContent(name: "Meal", image: #imageLiteral(resourceName: "icon_3")),
                     CategoryContent(name: "Transport", image: #imageLiteral(resourceName: "icon_5")),
                     CategoryContent(name: "Game", image: #imageLiteral(resourceName: "icon_6")),
                     CategoryContent(name: "Travel", image: #imageLiteral(resourceName: "icon_2")),
                     CategoryContent(name: "Home", image: #imageLiteral(resourceName: "icon_7")),
                     CategoryContent(name: "Family", image: #imageLiteral(resourceName: "icon_8")),
                     CategoryContent(name: "Pet", image: #imageLiteral(resourceName: "icon_9")),
                     CategoryContent(name: "Furniture", image: #imageLiteral(resourceName: "icon_10")),
                     CategoryContent(name: "Studies", image: #imageLiteral(resourceName: "icon_11")),
                     CategoryContent(name: "Technics", image: #imageLiteral(resourceName: "icon_12")),
                     CategoryContent(name: "Periphery", image: #imageLiteral(resourceName: "icon_13")),
                     CategoryContent(name: "Applications", image: #imageLiteral(resourceName: "icon_23")),
                     CategoryContent(name: "Presents", image: #imageLiteral(resourceName: "icon_15")),
                     CategoryContent(name: "Taxes", image: #imageLiteral(resourceName: "icon_21")),
                     CategoryContent(name: "Sex", image: #imageLiteral(resourceName: "icon_14")),
                     CategoryContent(name: "Jewelry", image: #imageLiteral(resourceName: "icon_16")),
                     CategoryContent(name: "Farm", image: #imageLiteral(resourceName: "icon_17")),
                     CategoryContent(name: "Clothes", image: #imageLiteral(resourceName: "icon_18")),
                     CategoryContent(name: "Medicines", image: #imageLiteral(resourceName: "icon_20")),
                     CategoryContent(name: "Health", image: #imageLiteral(resourceName: "icon_19")),
                     CategoryContent(name: "Woman Health", image: #imageLiteral(resourceName: "icon_22"))]

//MARK: - All classes and enums

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

//MARK: - Global functional class

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

//MARK: - User Defaulds class handler

enum ColorsKey
{
    static let systemBlue = "systemBlue"
    static let systemGreen = "systemGreen"
    static let systemYellow = "systemYellow"
    static let systemRed = "systemRed"
    static let MClightPink = "MClightPink"
    static let systemMint = "systemMint"
    static let systemOrange = "systemOrange"
    static let systemCyan = "systemCyan"
    static let systemIndigo = "systemIndigo"
    static let systemPurple = "systemPurple"
}

enum SettingsKays
{
    static let appTintColorName = "appTintColorName"
    static let moneySymbol = "moneySymbol"
    static let appLanguage = "appLanguage"
    static let appTapSoundName = "appTapSoundName"
    static let isSoundOn = "isSoundOn"
    static let isVibrationOn = "isVibrationOn"
}

struct SettingsHandler : Codable
{
    static var shared = SettingsHandler()
    
    var appTintColorName : String
    {
        get { return DataHandler.shared.loadAppTintColorName() }
        set { DataHandler.shared.saveAppTintColorName(appTintColorName: newValue) }
    }
    var moneySymbol : String
    {
        get { return DataHandler.shared.loadMoneySymbol() }
        set { DataHandler.shared.saveMoneySymbol(moneySymbol: newValue) }
    }
    var appLanguage: String
    {
        get { return DataHandler.shared.loadAppLanguage() }
        set { DataHandler.shared.saveAppLanguage(appLanguage: newValue) }
    }
    var appTapSoundName: String
    {
        get { return DataHandler.shared.loadAppTapSoundName() }
        set { DataHandler.shared.saveAppTapSoundName(appTapSoundName: newValue) }
    }
    var isSoundOn: Bool = true
    var isVibrationOn: Bool = true
}

class  DataHandler
{
    static let shared = DataHandler()
    
    private var userDefaults = UserDefaults.standard
    
    
    func saveMoneySymbol(moneySymbol: String)
    {
        guard let data = try? JSONEncoder().encode(moneySymbol) else {return}
        userDefaults.set(data, forKey: SettingsKays.moneySymbol)
    }
    func loadMoneySymbol() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.moneySymbol) as? Data else {return String()}
        guard let moneySymbol = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return moneySymbol
    }
    
    func saveAppLanguage(appLanguage: String)
    {
        guard let data = try? JSONEncoder().encode(appLanguage) else {return}
        userDefaults.set(data, forKey: SettingsKays.appLanguage)
    }
    func loadAppLanguage() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appLanguage) as? Data else {return String()}
        guard let appLanguage = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appLanguage
    }
    
    func saveAppTapSoundName(appTapSoundName: String)
    {
        guard let data = try? JSONEncoder().encode(appTapSoundName) else {return}
        userDefaults.set(data, forKey: SettingsKays.appTapSoundName)
    }
    func loadAppTapSoundName() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appTapSoundName) as? Data else {return String()}
        guard let appTapSoundName = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appTapSoundName
    }
    
    func saveAppTintColorName(appTintColorName: String)
    {
        guard let data = try? JSONEncoder().encode(appTintColorName) else {return}
        userDefaults.set(data, forKey: SettingsKays.appTintColorName)
    }
    func loadAppTintColorName() -> String
    {
        guard let data = self.userDefaults.object(forKey: SettingsKays.appTintColorName) as? Data else {return String()}
        guard let appTintColorName = try? JSONDecoder().decode(String.self, from: data) else {print("dddd"); return String()}
        return appTintColorName
    }
    
    
    
    //MARK: currency Array handler
    
    private var currencyArrayKey = "currencyArrayKey"
    
    func saveCurrencyArray(newArray:[String])
    {
        guard let data = try? JSONEncoder().encode(newArray) else {print("jjjj");return}
        userDefaults.set(data, forKey: self.currencyArrayKey)
    }
    
    func loadCurrencyArray() -> [String]
    {
        guard let data = self.userDefaults.object(forKey: self.currencyArrayKey) as? Data else {print("jjjjoooo");return []}
        guard let currencyArray = try? JSONDecoder().decode([String].self, from: data) else {print("jjjjppp");return []}

        return currencyArray
    }
    
    
    
    //MARK: userMonth Array handler
    
    private var userMonthKey = "userMonthKey"
    
    func saveUsersMonthArray(newArray:[MonthContent])
    {
        guard let data = try? JSONEncoder().encode(newArray) else {return}
        userDefaults.set(data, forKey: self.userMonthKey)
    }
    
    func loadUsersMonthArray() -> [MonthContent]
    {
        guard let data = self.userDefaults.object(forKey: self.userMonthKey) as? Data else {return []}
        guard let events = try? JSONDecoder().decode([MonthContent].self, from: data) else {return []}

        return events
    }
    
    
    
    //MARK: allCategory Array handler
    
    private var allCategoriesKey = "allCategoriesKey"
    
    func setDataCategories(events:[CategoryContent])
    {
        guard let data = try? JSONEncoder().encode(events) else {return}
        userDefaults.set(data, forKey: self.allCategoriesKey)
    }
    
    func loadDataCategories() -> [CategoryContent]
    {
        guard let data = userDefaults.object(forKey: self.allCategoriesKey) as? Data else {return []}
        guard let events = try? JSONDecoder().decode([CategoryContent].self, from: data) else {return []}
        
        return events
    }
}



//MARK: - Event Data class handler

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



//MARK: - Event class handler

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





//MARK: - Extentions

extension UIColor
{
    static let MCDarkLightBlue = UIColor(red: 70.0 / 255, green: 65.0 / 255, blue: 129 / 255, alpha: 1.0)
    static let MCBackg_2_r = UIColor(red: 49 / 255, green: 50.0 / 255, blue: 147 / 255, alpha: 1.0)
    static let MCTabBarSelectedColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    static let MCTabBarColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)
    static let MClightBlue = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let MClightPink = #colorLiteral(red: 1, green: 0.5211483836, blue: 1, alpha: 1)
    static let MClightCyan = #colorLiteral(red: 0, green: 0.9369763732, blue: 0.6537380219, alpha: 1)
}




//var localHistoryDateArray = [String]()
//var localHistoryDataDictionary = [String : [String]]()

//struct DataHandler{
//    var dataMinutes:String?
//    var dataMonth:String?
//    var dash:String?
//
//    init(dataString: String){
//        let stringArray:[String] = dataString.components(separatedBy: " ")
//        self.dataMinutes = stringArray[0]
//        self.dash = stringArray[1]
//        self.dataMonth = stringArray[3]
//    }
//}
//
//var localHistoryDateArray = [DataHandler]()
//
//
//var strStr = [String : [String]]()
//var str = [String]()
//
//func r(){
//    for i in mainScreenHistoryCell.history{
//        if var val = strStr[i.getStringDateMonth()]{
//            val.append(i.getStringDate())
//            strStr[i.getStringDateMonth()] = val
//        }
//        else{
//            strStr[i.getStringDateMonth()] = [i.getStringDate() ]
//        }
//    }
//    str = [String](strStr.keys)
//    print(str)
//}


//func fillLocalHistoryDateArray(index:Int){
//    for i in usersCategories[index].history{
//        let date = [DataHandler]()
//        date.
//        //localHistoryDateArray.append(contentsOf:)
//    }
//}
