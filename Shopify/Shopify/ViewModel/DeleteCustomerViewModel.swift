//
//  DeleteCustomerViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 23/02/2025.
//

import Foundation

class DeleteCustomerViewModel{
    var deleteCustomerInViewController : (()->()) = {}
    var deleteCustomerResult = CustomerDelete()
    {
        didSet{
            deleteCustomerInViewController()
        }
    }
    func deleteCustomerFromModel(accessToken : String?){
        guard let accessToken = accessToken else { return }
        ApolloCustomerDeleteService.deleteCustomer(customerAccessToken: accessToken , complitionHandler: {response in
            switch response{
            case .success(let result):
                let deleteCustomerResult = result.data?.customerAccessTokenDelete
                DispatchQueue.main.async{
                    self.deleteCustomerResult = CustomerDelete(deletedAccessToken: deleteCustomerResult?.deletedAccessToken , deletedCustomerAccessTokenId: deleteCustomerResult?.deletedCustomerAccessTokenId ,errors: Errors(field:deleteCustomerResult?.userErrors.first?.field,message: deleteCustomerResult?.userErrors.first?.message))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
