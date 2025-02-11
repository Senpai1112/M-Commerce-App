//
//  ViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//

import Foundation

class ViewModel {
    var bindBrandsToViewController: (() -> ()) = {}
    var finalResult: [SmartCollection] = [] {
        didSet {
            bindBrandsToViewController()
        }
    }

    func getBrandsFromModel() {
        Services.fetchBrands { [weak self] result in
            guard let result = result else { return }
            self?.finalResult = result
        }
    }
}

