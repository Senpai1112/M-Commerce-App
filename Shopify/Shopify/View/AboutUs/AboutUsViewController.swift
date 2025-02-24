//
//  AboutUsUsViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import UIKit

class AboutUsViewController: UIViewController {
    var aboutUs : String = "This application is our graduation project, try use this application and if you found any problem, Please contact us to solve it and improve our application."
    var team : String = "Our Team :\n Youssab Yasser \n Rokaya El Shahid \n Mai Atef"
    
    var contactUs : String = "email : Shopify@gmail.com \n phone : 01200175054"
    
    var isAboutUs : Bool = false
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isAboutUs{
            textLabel.text = aboutUs
            teamLabel.text = team
        }else{
            textLabel.text = contactUs
        }
    }
    
    func initUI(){
        textLabel.textColor = UIColor.purple
        teamLabel.textColor = UIColor.purple
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
