//
//  UserViewController.swift
//  ReccostApp
//
//  Created by And Nik on 30.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox


//MARK: - User View Controller Delegate extansion

extension UserViewController : ReloadDataDelegate
{
    func popBackViewController()
    {
        return
    }
    
    func reloadViewController()
    {
        usersMonths.sort(by: { $0.date! > $1.date!})
        self.monthCollectionView.reloadData()
    }
}



//MARK: - User view controller

class UserViewController: UIViewController
{
    let nowDate = Date()
    
    var selectedIndex = IndexPath(row: -1, section: -1)
    
    let customNavigationBarView = UIView()
    func customNavigationBarViewConfig()
    {
        self.customNavigationBarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.customNavigationBarView.backgroundColor = .tertiarySystemBackground
        
        self.view.addSubview(self.customNavigationBarView)
        
        NSLayoutConstraint.activate([
            self.customNavigationBarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.customNavigationBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.customNavigationBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.customNavigationBarView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        self.customNavigationBarView.layoutIfNeeded()
        
        self.customNavigationBarView.addSubview(GlobalFunctional.drawLine(rect: CGRect(x: 0, y: self.customNavigationBarView.frame.height, width: self.customNavigationBarView.frame.width, height: 1), color: .systemGray5))
        
    }
    
    let profilImageView = UIImageView()
    func profilImageViewConfig()
    {
        self.profilImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.customNavigationBarView.addSubview(self.profilImageView)
        
        NSLayoutConstraint.activate([
            self.profilImageView.widthAnchor.constraint(equalToConstant: 60),
            self.profilImageView.heightAnchor.constraint(equalToConstant: 60),
            self.profilImageView.centerYAnchor.constraint(equalTo: self.customNavigationBarView.centerYAnchor),
            self.profilImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20)
        ])
        
        self.profilImageView.layoutIfNeeded()
        
        self.profilImageView.layer.borderWidth = 3
        self.profilImageView.layer.borderColor = UIColor.white.cgColor
        self.profilImageView.layer.cornerRadius = self.profilImageView.frame.height/2
        self.profilImageView.layer.masksToBounds = true
        
        self.profilImageView.contentMode = .scaleAspectFill
        self.profilImageView.backgroundColor = .clear
    }
    
    let profilNameLabel = UILabel()
    func profilNameLabelConfig()
    {
        self.profilNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.customNavigationBarView.addSubview(self.profilNameLabel)
        
        self.profilNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 85).isActive = true
        self.profilNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -85).isActive = true
        self.profilNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.profilNameLabel.centerXAnchor.constraint(equalTo: self.customNavigationBarView.centerXAnchor).isActive = true
        self.profilNameLabel.centerYAnchor.constraint(equalTo: self.customNavigationBarView.centerYAnchor).isActive = true
        
        self.profilNameLabel.font = .boldSystemFont(ofSize: 18)
        self.profilNameLabel.numberOfLines = 2
        self.profilNameLabel.textColor = appTitleColor
        self.profilNameLabel.textAlignment = .center
    }
    
    let headerImage = UIImageView()
    private func headerImageConfig()
    {
        self.headerImage.layer.insertSublayer(GlobalFunctional.addGradient(bounds: self.view.bounds,
                                                                    colors: [#colorLiteral(red: 0, green: 0.9369763732, blue: 0.6537380219, alpha: 1).cgColor, UIColor.systemBackground.cgColor],
                                                                    startPoint: CGPoint(x: 1, y: 1),
                                                                    endPoint: CGPoint(x: 0, y: 0)), at: 0)
        
        self.headerImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.height, height: 300)
        self.headerImage.contentMode = .scaleAspectFill
        self.headerImage.clipsToBounds = true
        
        self.view.addSubview(headerImage)
    }
    
    let monthCollectionView = MonthCollecttionView()
    func monthCollectionViewConfig()
    {
        self.monthCollectionView.delegate = self
        self.monthCollectionView.dataSource = self
        
        self.view.addSubview(monthCollectionView)
        
        self.monthCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.monthCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.monthCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.monthCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    let addButton = UIButton()
    func addButtonConfig()
    {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let plusLabel = UILabel()
        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 40)
        plusLabel.textColor = .white
        plusLabel.textAlignment = .center
        plusLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addButton.addSubview(plusLabel)

        plusLabel.leadingAnchor.constraint(equalTo: self.addButton.leadingAnchor, constant: 2).isActive = true
        plusLabel.trailingAnchor.constraint(equalTo: self.addButton.trailingAnchor).isActive = true
        plusLabel.topAnchor.constraint(equalTo: self.addButton.topAnchor).isActive = true
        plusLabel.bottomAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: -6).isActive = true
        
        self.view.addSubview(self.addButton)
        
        self.addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        self.addButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.addButton.layoutIfNeeded()
        
        self.addButton.layer.cornerRadius = self.addButton.bounds.width / 2
        
        self.addButton.layer.shadowRadius = 20
        self.addButton.layer.shadowColor = #colorLiteral(red: 0.9542962909, green: 0.3194703758, blue: 1, alpha: 1).cgColor
        self.addButton.layer.shadowOpacity = 0.7
        
        let gradient = GlobalFunctional.addGradient(bounds: self.addButton.bounds,
                                             colors: [#colorLiteral(red: 0.9542962909, green: 0.3194703758, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.5551471114, blue: 1, alpha: 1).cgColor],
                                             startPoint: CGPoint(x: 0, y: 0),
                                             endPoint: CGPoint(x: 1, y: 1))
        
        gradient.cornerRadius = self.addButton.bounds.width / 2
        
        self.addButton.layer.insertSublayer(gradient, at: 0)
        
        self.addButton.addTarget(self,
                                 action: #selector(addButtonTarget),
                                 for: .touchUpInside)
    }
     
    @objc func addButtonTarget()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        let allCategoryVC = CategoriesViewController()
        self.present(UINavigationController(rootViewController: allCategoryVC), animated: true)
        
        allCategoryVC.allCategoriesDelegate = self// ------ [DELEGATE INITIALISATION RELISED] --------
        print("lll")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .tertiarySystemBackground
        
        self.monthCollectionViewConfig()
        self.customNavigationBarViewConfig()
        self.profilImageViewConfig()
        self.profilNameLabelConfig()
        
        self.addButtonConfig()
        
        
        usersMonths = DataHandler.shared.loadUsersMonthArray()// --------   [USER DEFAULTS LOAD DATA]   ---------
        usersMonths.sort(by: { $0.date! > $1.date!})
        
        self.navigationItem.title = "Profil"
        self.navigationController?.navigationBar.tintColor = appTintColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.profilImageView.image = user.getImage()
        self.profilNameLabel.text = user.getName() + "\n" + user.getSurname()
        self.monthCollectionView.reloadData()
    }
    
}



//MARK: - Extention User View Controller collection view

extension UserViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return usersMonths.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 90, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.reuseID, for: indexPath) as! MonthCollectionViewCell
        
        cell.cellConfig(textDate: usersMonths[indexPath.item].getFullNameOfMonth())
        
        if usersMonths[indexPath.item].getMonth() == GlobalFunctional.getStringMonthInYer(nowDate)
        {
            cell.selectedCell()
        }
        else
        {
            cell.deselectedCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if SettingsHandler.shared.isSoundOn {do{audioPlayer = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource:SettingsHandler.shared.appTapSoundName,ofType:"wav")!));audioPlayer?.play()}catch{}}
        if SettingsHandler.shared.isVibrationOn {GlobalFunctional.vibrateTapFeedback()}
        
        self.selectedIndex = indexPath
        
        usersMonths[indexPath.item].sortArray()
        
        selectedMonthIndex = indexPath.item

        self.monthCollectionView.reloadItems(at: [indexPath])
        
        let monthVC = MonthViewController()
        monthVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(monthVC, animated: true)
        
        monthVC.delegateeee = self// ------ [DELEGATE INITIALISATION RELISED] --------
    }
    
}





//MARK: - Collection view

class MonthCollecttionView : UICollectionView
{
    init()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.minimumLineSpacing = 30
        
        self.contentInset = UIEdgeInsets(top: 80, left: 40, bottom: 0, right: 40)
        self.contentMode = .center
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.backgroundColor = appBackgroundColor
        
        self.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.reuseID)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}



//MARK: - Collection view cell

class MonthCollectionViewCell : UICollectionViewCell
{
    static let reuseID = "MonthCollectionViewCell"
    
    private let infoView = UIView()
    private func infoViewConfig()
    {
        self.infoView.backgroundColor = appCellBackgroundColor
        self.infoView.translatesAutoresizingMaskIntoConstraints = false

        self.infoView.layer.cornerRadius = self.frame.width/4
        
        self.addSubview(self.infoView)
        
        self.infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.infoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.infoView.layer.shadowRadius = 10
        self.infoView.layer.shadowOpacity = 0.1
        self.infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private let monthLabel = UILabel()
    private func monthLabelConfig()
    {
        self.monthLabel.text = "Sep 2020"
        
        self.monthLabel.numberOfLines = 2
        self.monthLabel.font = .boldSystemFont(ofSize: 23)
        self.monthLabel.textAlignment = .left
        
        self.monthLabel.frame = CGRect(x: 20, y: 10, width: 70, height: 70)
        
        self.addSubview(self.monthLabel)
    }
    
    private let nowLabel = UILabel()
    private func nowLabelConfig()
    {
        self.nowLabel.text = "Now"
        
        self.nowLabel.numberOfLines = 1
        self.nowLabel.font = .systemFont(ofSize: 18)
        self.nowLabel.textColor = .white
        self.nowLabel.textAlignment = .left
        
        self.nowLabel.frame = CGRect(x: 20, y: 5, width: 90, height: 15)
        
        self.addSubview(self.nowLabel)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.infoViewConfig()
        self.monthLabelConfig()
        self.nowLabelConfig()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func cellConfig(textDate: String)
    {
        self.monthLabel.text = textDate
    }
    
    func selectedCell()
    {
        self.nowLabel.isHidden = false
        self.monthLabel.textColor = .white
        self.infoView.backgroundColor = appTintColor
    }
    
    func deselectedCell()
    {
        self.nowLabel.isHidden = true
        self.infoView.backgroundColor = appCellBackgroundColor
        self.monthLabel.textColor = appTitleColor
    }
    
    func animate()
    {
        UIView.animate(withDuration: 0.5, animations: {self.infoView.frame = CGRect(x: 0, y: 20, width: self.infoView.bounds.width, height: self.infoView.bounds.height)})
        print("..........")
    }
}
