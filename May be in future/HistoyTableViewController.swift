//
//  HistoyTableViewController.swift
//  ReccostApp
//
//  Created by And Nik on 14.09.22.
//
//
//import UIKit
//
//class HistoyTableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.navigationItem.title = "History"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        self.navigationItem.titleView?.tintColor = .white
//        self.navigationItem.titleView?.backgroundColor = .orange
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        print("???????????????RRRRR?R?R??RR?R?R?R?R?R?R??R?R?")
//        reloadInputViews()
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return historyArray.count
//        //return usersCategories[3].history.count
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 115
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
//
//        //cell.setSettings(event: historyArray[indexPath.item])
//        cell.setSettings(event: usersCategories[indexPath.item])
//        print("--------cell created----------")
//
//        return cell
//    }
//
//}
//
//
//
//class HistoryTableViewCell: UITableViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    @IBOutlet weak var categoryImage: UIImageView!
//    @IBOutlet weak var categoryLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var descriptionTextView: UITextView!
//    @IBOutlet weak var dateLabel: UILabel!
//
//    func setSettings(event: CategoryContent){
//        print("000000000000",event.getName(), event.history[0].getStringDate(), event.history[0].getPrice())//out of range!!!!!!!!!!!!!!!!!!!!!!!!!!1!
//        categoryLabel.text = event.getName()
//        categoryImage.image = event.getImage()
//        priceLabel.text = String(event.history[0].getPrice()) + " " + SettingsHandler.shared.moneySymbol
//        priceLabel.textColor = #colorLiteral(red: 0, green: 0.8237728477, blue: 0, alpha: 1)
//        descriptionTextView.textColor = .gray
//        dateLabel.text = event.history[0].getStringDate()
//        dateLabel.textColor = .gray
//        if event.history[0].getDescription() == ""{
//            descriptionTextView.text = "No discription"
//        }
//        else{
//            descriptionTextView.text = event.history[0].getDescription()
//        }
//    }
//
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
