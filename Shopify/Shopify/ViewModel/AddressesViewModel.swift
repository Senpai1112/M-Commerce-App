//
//  AddressesViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import Foundation
import Apollo

class AddressesViewModel{
    var bindResultToAddressDetailsTableViewController : (()->()) = {}
    var addressResult = [Addresses]()
    {
        didSet{
            bindResultToAddressDetailsTableViewController()
        }
    }
    
    func getAddressesFromModel(customerAccessToken : String?) {
        ApolloNetwokService.fetchCustomerAddresses(token: customerAccessToken ?? "", completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.addresses {
                    let finals = collections.edges.compactMap { $0.node }
                    let addressModel = finals.map { address in
                        return Addresses(country: address.country ,city: address.city, address1: address.address1,address2: address.address2,phone: address.phone,id: address.id)
                    }
                    DispatchQueue.main.async {
                        self?.addressResult = addressModel
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    var bindResultToAddAddressViewController : (()->()) = {}
    var addedAddressResult = [Addresses]()
    {
        didSet{
            bindResultToAddAddressViewController()
        }
    }
    
    func createAddressInModel(customerAccessToken : String? , address : Addresses) {
        ApolloNetwokService.fetchCustomerAddresses(token: customerAccessToken ?? "", completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.addresses {
                    let finals = collections.edges.compactMap { $0.node }
                    let addressModel = finals.map { address in
                        return Addresses(country: address.country ,city: address.city, address1: address.address1,address2: address.address2,phone: address.phone,id: address.id)
                    }
                    DispatchQueue.main.async {
                        self?.addedAddressResult = addressModel
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}



