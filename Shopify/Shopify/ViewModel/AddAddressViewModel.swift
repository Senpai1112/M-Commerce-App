//
//  AddAddressViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 16/02/2025.
//

import Foundation

class AddAddressViewModel{
    var bindResultToAddAddressViewController : (()->()) = {}
    var bindErrorToAddAddressViewController : (()->()) = {}
    var addedAddressResult = Addresses()
    {
        didSet{
            bindResultToAddAddressViewController()
        }
    }
    var addedAddressError = Errors()
    {
        didSet{
            bindErrorToAddAddressViewController()
        }
    }
    
    func createAddressInModel(customerAccessToken : String? , address : Addresses) {
        ApolloNetwokService.createCustomerAddresses(token: customerAccessToken ?? "", address: address, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let error = data.data?.customerAddressCreate?.customerUserErrors , !error.isEmpty{
                    let errorMessage = error.map{
                        return $0.message
                    }
                    self?.addedAddressError.message = errorMessage.first
                    return
                }
                if data.data != nil{
                    DispatchQueue.main.async{
                        self?.addedAddressResult = address
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
