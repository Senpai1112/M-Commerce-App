//
//  MeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 18/02/2025.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchIconToNavigationBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Me"

    }
    func addSearchIconToNavigationBar() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonTapped))
        self.navigationItem.rightBarButtonItem = searchButton
    }

    @objc func searchButtonTapped() {
        print("Search button tapped")
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
