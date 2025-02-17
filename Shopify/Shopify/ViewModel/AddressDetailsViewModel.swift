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
        guard customerAccessToken != nil else {
            print("Invalid customer access token.")
            return
        }
        ApolloNetwokService.fetchCustomerAddresses(token: customerAccessToken!, completion: { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.customer?.addresses {
                    let addressModel = collections.edges.map { edge in
                        let address = Addresses(
                            country: edge.node.country,
                            city: edge.node.city,
                            address1: edge.node.address1,
                            address2: edge.node.address2,
                            phone: edge.node.phone,
                            id: edge.node.id
                        )
                        return address
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
    func deleteAddressesFromModel(customerAccessToken : String? , addressId : String? , indexPath : IndexPath) {
        guard let token = customerAccessToken, let id = addressId else {
            print("Invalid token or address id.")
            return
        }
        ApolloNetwokService.deleteCustomerAddresses(token: customerAccessToken!, addressid: addressId!, completion: { [weak self] result in
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



