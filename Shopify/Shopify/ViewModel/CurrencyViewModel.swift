//
//  CurrencyViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 22/02/2025.
//

import Foundation

class CurrencyViewModel{
    var bindResultToViewController : (()->()) = {}
    
    var currencyResult : CurrencyModel!
    {
        didSet{
            bindResultToViewController()
        }
    }
    
    func fetchCurrencyFromModel(){
        CurrencyApiService.fetchCurreny(complitionHandler: {
            result in
            guard let result = result else {return}
            self.currencyResult = result
        })
    }
}
