//
//  SettingsViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 13/02/2025.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let titles = ["Address" , "Currency" , "Contact Us","About Us"]
    let details = ["address" , "EGP" ,"",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
    }
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    func initUI(){
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        logoutButton.layer.cornerCurve = .continuous
        logoutButton.clipsToBounds = true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SettingsViewController : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.detailsLabel.text = details[indexPath.row]
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
