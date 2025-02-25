//
//  SendEmailViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 25/02/2025.
//

import Foundation
import MyApi

class SendEmailViewModel{
    var mailResult : (()->()) = {}
    
    var bindMailResult : String? {
        didSet{
            mailResult()
        }
    }
    
    func sendMailForCustomer(customerDetails : CustomerDetails , address : Addresses , carResponse : CartResponse){
        //SendOrderWithApi.shared.apollo.fetch(query: CustomerOrdersQuery)
    }
}
