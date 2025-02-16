//
//  AddressesViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import Foundation
import Apollo

class AddressDetailsViewModel{
    var bindResultToAddressDetailsTableViewController : (()->()) = {}
    var addressResult = [Addresses]()
    {
        didSet{
            bindResultToAddressDetailsTableViewController()
        }
    }
    
    func getAddressesFromModel(customerAccessToken : String?) {
        ApolloNetwokService.fetchCustomerAddresses(token: customerAccessToken!, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.addresses {
                    let finals = collections.edges.compactMap { $0.node }
                    let addressModel = finals.map { address in
                        return Addresses(country: address.country ,city: address.city, address1: address.address1,address2: address.address2,phone: address.phone,id: address.id)
                    }
                    DispatchQueue.main.async {
                        self?.addressResult.removeAll()
                        self?.addressResult = addressModel
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteAddressesFromModel(customerAccessToken : String? , addressId : String? , indexPath : IndexPath) {
        ApolloNetwokService.deleteCustomerAddresses(token: customerAccessToken!, addressid: addressId!, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if data.data != nil{
                    DispatchQueue.main.async {                        self?.addressResult.remove(at: indexPath.row)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}



