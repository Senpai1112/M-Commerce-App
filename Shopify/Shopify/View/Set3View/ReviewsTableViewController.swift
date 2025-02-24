//
//  ReviewsTableViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 23/02/2025.
//

import UIKit

class ReviewsTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewsTableViewCell
         switch indexPath.row {
         case 0:
             cell.cellImage.image = UIImage(named: "girl1")
             cell.date.text = "2025-02-23"
             cell.name.text = "Sara"
             cell.rating.text = "4.8"
             cell.review.text = "Great product! The material is high quality, and it feels really durable. Definitely worth the price!"
         case 1:
             cell.cellImage.image = UIImage(named: "boy3")
             cell.date.text = "2024-11-01"
             cell.name.text = "Hazem"
             cell.rating.text = "4.6"
             cell.review.text = "Decent product for the price. The material feels good, though the color isn’t exactly what I thought. Still, it's a solid choice for the value."
         case 2:
             cell.cellImage.image = UIImage(named: "boy4")
             cell.date.text = "2024-12-07"
             cell.name.text = "Ehab"
             cell.rating.text = "5.0"
             cell.review.text = "I’m really happy with this purchase. It looks just like the picture and is functional. A great addition to my collection!"
         case 3:
             cell.cellImage.image = UIImage(named: "girl2")
             cell.date.text = "2024-08-07"
             cell.name.text = "Mariam"
             cell.rating.text = "4.9"
             cell.review.text = "Great product! The quality is top-notch and durable. It’s perfect for everyday use, and the design is sleek and stylish."
         default:
             cell.cellImage.image = UIImage(named: "girl3")
             cell.date.text = "2024-02-23"
             cell.name.text = "Mai"
             cell.rating.text = "4.7"
             cell.review.text = "Excellent value for money, I love it!"
             
             
         }
        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }

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

}
