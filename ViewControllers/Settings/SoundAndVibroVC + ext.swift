//
//  SoundAndVibroVC + ext.swift
//  ReccostApp
//
//  Created by And Nik on 12.01.23.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


//Sound Info struct

struct SoundInfo
{
    var id = String()
    var name = String()
    
    init(id: String, name: String)
    {
        self.id = id
        self.name = name
    }
}



//MARK: - Sound And Vibro ViewController

class SoundAndVibroViewController : UIViewController
{
    //var soundsArray = [1057, 1157, 1340, 1344, 1345]
    var soundsArray = [SoundInfo(id: "sound_1", name: "Tink"),
                       SoundInfo(id: "sound_2", name: "Clock"),
                       //SoundInfo(id: 1340, name: "Note"),
                       SoundInfo(id: "sound_3", name: "Keyboard voiced"),
                       SoundInfo(id: "sound_4", name: "Keyboard deaf")]
    
    var selectedIndex = IndexPath()
    
    let soundsTableView = UITableView(frame: .zero, style: .insetGrouped)
    func soundsTableViewConfig()
    {
        self.soundsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.soundsTableView.backgroundColor = .clear
        
        self.soundsTableView.delegate = self
        self.soundsTableView.dataSource = self
        
        self.soundsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.soundsTableView.register(DefaultSwitchTableViewCell.self, forCellReuseIdentifier: DefaultSwitchTableViewCell.reuseID)
        
        self.view.addSubview(self.soundsTableView)
        
        self.soundsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.soundsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.soundsTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.soundsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = appBackgroundColor
        
        self.soundsTableViewConfig()
        
        self.navigationItem.title = "Sound and vibration"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.tintColor = appTintColor
        
        for index in self.soundsArray.indices where soundsArray[index].id == SettingsHandler.shared.appTapSoundName
        {
            self.selectedIndex = IndexPath(row: index, section: 1)
            self.soundsTableView.selectRow(at: IndexPath(row: index, section: 1), animated: false, scrollPosition: .none)
        }
    }
    
    @objc func handleSound(sender: UISwitch)
    {
        if sender.isOn
        {
            do{audioPlayer = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource:SettingsHandler.shared.appTapSoundName,ofType:"wav")!));audioPlayer?.play()}catch{}
        }
        SettingsHandler.shared.isSoundOn = sender.isOn
        self.soundsTableView.reloadSections(IndexSet(integer: 1), with: .none)
        print("1111tttttt")
    }
    
    @objc func handleVibration(_ sender: UISwitch)
    {
        if sender.isOn
        {
            GlobalFunctional.errorVibrateFeedback()
        }
        SettingsHandler.shared.isVibrationOn = sender.isOn
        print("2222hhhhhh")
    }
}

extension SoundAndVibroViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section
        {
        case 0: return ""
        case 1: return "TAP SOUND IN APPLICATION"
        case 2: return ""
        default: return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        switch section
        {
        case 0: return ""
        case 1: return "Select the sound from the list to be used in the application."
        case 2: return ""
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0: return 1
        case 1: return self.soundsArray.count
        case 2: return 1
        default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSwitchTableViewCell.reuseID, for: indexPath) as! DefaultSwitchTableViewCell
            cell.cellConfig(text: "Sound")
            cell.switchOnOff.isOn = SettingsHandler.shared.isSoundOn
            cell.switchOnOff.tag = indexPath.row
            cell.switchOnOff.addTarget(self,
                                       action: #selector(handleSound),
                                       for: .valueChanged)
            return cell
        case 1:
            let cell = self.soundsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = soundsArray[indexPath.row].name
            cell.tintColor = appTintColor
            cell.selectionStyle = .none
            if self.selectedIndex == indexPath
            {
                cell.accessoryType = .checkmark
            }
            else
            {
                cell.accessoryType = .none
            }
            if SettingsHandler.shared.isSoundOn
            {
                cell.tintColor = appTintColor
                cell.isUserInteractionEnabled = true
            }
            else
            {
                cell.tintColor = .secondaryLabel
                cell.isUserInteractionEnabled = false
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSwitchTableViewCell.reuseID, for: indexPath) as! DefaultSwitchTableViewCell
            cell.cellConfig(text: "Vibration")
            cell.switchOnOff.isOn = SettingsHandler.shared.isVibrationOn
            cell.switchOnOff.tag = indexPath.row
            cell.switchOnOff.addTarget(self,
                                       action: #selector(handleVibration(_ :)),
                                       for: .valueChanged)
            return cell
        default: return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            self.selectedIndex = indexPath
            SettingsHandler.shared.appTapSoundName = self.soundsArray[indexPath.row].id
            
            GlobalFunctional.soundAndVibrationObserver()
            
            self.soundsTableView.reloadSections(IndexSet(integer: 1), with: .none)

        }
    }
}
