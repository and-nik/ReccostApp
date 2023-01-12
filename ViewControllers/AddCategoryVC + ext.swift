//
//  AddCategoryController.swift
//  ReccostApp
//
//  Created by And Nik on 16.09.22.
//

import UIKit
import AVFoundation
import AudioToolbox


// MARK: - Class view

class AddCategoryViewController : UIViewController
{
    var delegate:AddCategoryViewControllerDelegate? // ------ [DELEGATE INITIALISATION] --------
    
    var iconsArray:[UIImage] = []
    let CELL_IN_ROW_COUNT = 5
    var image:UIImage?
    
    let backgroundImage = UIImageView()
    func backgroundImageConfig()
    {
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundImage.image = UIImage(named: "backg_7")
        self.backgroundImage.contentMode = .scaleAspectFill
        
        //self.view.insertSubview(self.backgroundImage, at: 0)
        self.view.addSubview(self.backgroundImage)
        
        self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    let iconsCollectionView = IconsCollectionView()
    func iconsCollectionViewConfig()
    {
        self.view.addSubview(self.iconsCollectionView)
        
        self.iconsCollectionView.delegate = self
        self.iconsCollectionView.dataSource = self
        
        self.iconsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.iconsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.iconsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.iconsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.backgroundImageConfig()
        self.iconsCollectionViewConfig()
        
        self.navigationController?.navigationBar.backgroundColor = appBackgroundColor
        self.navigationController?.navigationBar.tintColor = appTintColor //change items color in navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appTitleColor]
        self.navigationItem.title = "Choose icon image"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                 target: self,
                                                                 action: #selector(handleBack))
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                                                                 target: self,
//                                                                 action: #selector(handleAdd))
        
        for i in 0...64
        {
            let image = UIImage(named: "icon_\(i)")!
            iconsArray.append(image)
        }
    }
    
    @objc func handleBack()
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        self.dismiss(animated: true)
    }
    
//    @objc func handleAdd()
//    {
//        self.dismiss(animated: true)
//    }
    
}

extension AddCategoryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //numb of row
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return iconsArray.count
    }

    //cell customizer
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryViewControllerCell.reuseID, for: indexPath) as! AddCategoryViewControllerCell
        cell.cellConfig(image: iconsArray[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let FRAME_CV = collectionView.frame
        let CELL_WIDTH = FRAME_CV.width/CGFloat(CELL_IN_ROW_COUNT)

        return CGSize(width: CELL_WIDTH, height: CELL_WIDTH)
    }
    
    //cell sellect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        GlobalFunctional.soundAndVibrationObserver()
        
        print(indexPath.item)
        image = iconsArray[indexPath.item]
        delegate?.setImage(image: image!)
        self.dismiss(animated: true)
    }

}


class IconsCollectionView : UICollectionView
{
    init()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        layout.minimumLineSpacing = 30
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.contentMode = .center
        self.backgroundColor = appCellBackgroundColor
        
        self.register(AddCategoryViewControllerCell.self, forCellWithReuseIdentifier: AddCategoryViewControllerCell.reuseID)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}



//MARK: - Add Category View Controller Cell

class AddCategoryViewControllerCell : UICollectionViewCell
{
    static let reuseID = "CategoriesTableViewCell"
    
    let iconImageView = UIImageView()
    func iconImageViewConfig()
    {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.iconImageView.image = UIImage(named: "tap")
        self.iconImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.iconImageView)
        
        self.iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.height/4
        self.layer.masksToBounds = true
        self.backgroundColor = appBackgroundColor
        
        self.iconImageViewConfig()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(image: UIImage)
    {
        self.iconImageView.image = image
    }
}
