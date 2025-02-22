//
//  AddAddressViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 16/02/2025.
//

import Foundation

class UpdateAddressViewModel{
    var bindResultToUpdateAddressViewController : (()->()) = {}
    var bindErrorToUpdateAddressViewController : (()->()) = {}
    var updatedAddressResult = Addresses()
    {
        didSet{
            bindResultToUpdateAddressViewController()
        }
    }
    var updatedAddressError = Errors()
    {
        didSet{
            bindErrorToUpdateAddressViewController()
        }
    }
    
    func updateAddressInModel(customerAccessToken : String? , address : Addresses?) {
        ApolloAddressesNetwokService.updateCustomerAddresses(token: customerAccessToken ?? "", address: address!, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let error = data.data?.customerAddressUpdate?.customerUserErrors , !error.isEmpty{
                    let errorMessage = error.map{
                        return $0.message
                    }
                    self?.updatedAddressError.message = errorMessage.first
                    return
                }
                if data.data != nil{
                    DispatchQueue.main.async{
                        if let address = data.data?.customerAddressUpdate?.customerAddress{
                            self?.updatedAddressResult = Addresses(country: address.country ,city: address.city , address1: address.address1 , address2: address.address2 , phone : address.phone,id: address.id)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
