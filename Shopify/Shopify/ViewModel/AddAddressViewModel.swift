//
//  AddAddressViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 16/02/2025.
//

import Foundation

class AddAddressViewModel{
    var bindResultToAddAddressViewController : (()->()) = {}
    var addedAddressResult = Addresses()
    {
        didSet{
            bindResultToAddAddressViewController()
        }
    }
    
    func createAddressInModel(customerAccessToken : String? , address : Addresses) {
        ApolloNetwokService.createCustomerAddresses(token: customerAccessToken ?? "", address: address, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if data.data != nil{
                    DispatchQueue.main.async {
                        self?.addedAddressResult = address
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
