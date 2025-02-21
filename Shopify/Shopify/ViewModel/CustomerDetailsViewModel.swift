//
//  CustomerDetailsViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import Foundation

class CustomerDetailsViewModel {
    
    var bindResultToPaymentMethod : (()->()) = {}
    
    var customerDetails = CustomerDetails()
    {
        didSet{
            bindResultToPaymentMethod()
        }
    }
    
    func getCustomerDetails(customerAccessToken : String?){
        guard let customerAccessToken = customerAccessToken else { return }
        ApolloCustomerNetworkService.fetchCustomerDetailsFromModel(token: customerAccessToken, completion: {response in
            switch response{
            case .success(let result):
                let customer = result.data?.customer
                let customerDetails = CustomerDetails(displayName: customer?.displayName, email: customer?.email, firstName: customer?.firstName, id: customer?.id, lastName: customer?.lastName, phone: customer?.phone)
                DispatchQueue.main.async{
                    self.customerDetails = customerDetails
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
