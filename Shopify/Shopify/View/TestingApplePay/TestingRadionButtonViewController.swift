//
//  TestingRadionButtonViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit


class RadioButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        self.setImage(UIImage(systemName: "circle"), for: .normal) // Unselected state
        self.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected) // Selected state
        self.addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
    }

    @objc private func toggleSelection() {
        if self.isSelected == true{
            self.isSelected = false
        }
        else{
            self.isSelected = true
        }
    }
}

class TestingRadionButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var radioButton = RadioButton(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
        view.addSubview(radioButton)
        // Do any additional setup after loading the view.
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
