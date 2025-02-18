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
    var bindResultToSettingTableViewController : (()->()) = {}
    var addressResult = [Addresses]()
    {
        didSet{
            bindResultToAddressDetailsTableViewController()
        }
    }
    
    var defaultAddressResult = Addresses()
    {
        didSet{
            bindResultToSettingTableViewController()
        }
    }
    
    func getAddressesFromModel(customerAccessToken : String?) {
        guard customerAccessToken != nil else {
            print("Invalid customer access token.")
            return
        }
        ApolloAddressesNetwokService.fetchCustomerAddresses(token: customerAccessToken!, completion: {  result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.addresses {
                    let addressModel = collections.edges.map { edge in
                        return Addresses(
                            country: edge.node.country,
                            city: edge.node.city,
                            address1: edge.node.address1,
                            address2: edge.node.address2,
                            phone: edge.node.phone,
                            id: edge.node.id
                        )
                    }
                    DispatchQueue.main.async {
                        self.addressResult = addressModel
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getDefaultAddressesFromModel(customerAccessToken : String?) {
        guard customerAccessToken != nil else {
            print("Invalid customer access token.")
            return
        }
        ApolloAddressesNetwokService.fetchCustomerDefaultAddresses(token: customerAccessToken!, completion: {  result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.defaultAddress {
                    DispatchQueue.main.async {
                        self.defaultAddressResult = Addresses(
                            country: collections.country,
                            city: collections.city,
                            address1: collections.address1,
                            address2: collections.address2,
                            phone: collections.phone,
                            id: collections.id
                        )
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    func deleteAddressesFromModel(customerAccessToken : String? , addressId : String? , indexPath : IndexPath) {
        guard let token = customerAccessToken, let id = addressId else {
            print("Invalid token or address id.")
            return
        }
        ApolloAddressesNetwokService.deleteCustomerAddresses(token: customerAccessToken!, addressid: addressId!, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if data.data != nil{
                    DispatchQueue.main.async {
                        self?.addressResult.remove(at: indexPath.row)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}



