//
//  CartViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import Foundation
import Apollo
import MyApi

class CartViewModel{
    var bindResultToShoppingCartTableViewController : (()->()) = {}
    
    var cartResult = CartResponse()
    {
        didSet{
            bindResultToShoppingCartTableViewController()
        }
    }
    
    var localCartResult = CartResponse()
    func parseCartResponse(from data: FetchCartByIdQuery.Data) -> CartResponse? {
        // Ensure the top-level cart exists
        guard let cartData = data.cart else { return nil }
        
        // A helper function that maps a cost amount into our Cost model while ignoring currencyCode.
        func mapCost(amount: String?) -> Cost? {
            guard let amount = amount else { return nil }
            return Cost(amount: amount, currencyCode: nil) // ignore currencyCode
        }
        
        // Map the cart-level cost
        let totalCost: TotalCost? = {
            let cost = cartData.cost
            return TotalCost(
                checkoutChargeAmount: mapCost(amount: cost.checkoutChargeAmount.amount),
                subtotalAmount: mapCost(amount: cost.subtotalAmount.amount),
                totalAmount: mapCost(amount: cost.totalAmount.amount)
            )
        }()
        
        // Map each cart line into a Cart instance
        let cartItems: [Cart] = cartData.lines.edges.map { line in
            var cartItem = Cart()
            cartItem.id = line.node.id
            
            // Map merchandise (assuming an inline fragment for ProductVariant is available)
            if let productVariant = line.node.merchandise.asProductVariant {
                var merch = Merchendise(id: productVariant.id)
                merch.availableQuantity = productVariant.quantityAvailable != nil ? productVariant.quantityAvailable! : 0
                merch.title = productVariant.title
                merch.image = productVariant.image?.url
                cartItem.merchandise = merch
            }
            
            // Convert line quantity to String
            cartItem.quantity = line.node.quantity
            
            // Map the cost for the line item (ignoring currency code)
            cartItem.cost = {
                let lineCost = line.node.cost
                return TotalCost(
                    checkoutChargeAmount: mapCost(amount: lineCost.amountPerQuantity.amount),
                    subtotalAmount: mapCost(amount: lineCost.subtotalAmount.amount),
                    totalAmount: mapCost(amount: lineCost.totalAmount.amount)
                )
            }()
            
            return cartItem
        }
        
        // Build and return the final CartResponse model
        let cartResponse = CartResponse(
            checkoutUrl: cartData.checkoutUrl,
            id: cartData.id,
            totalQuantity: cartData.totalQuantity,
            totalCost: totalCost,
            cart: cartItems
        )
        
        return cartResponse
    }
    
    
    func getCartFromModel(cartID : String?) {
        guard cartID != nil else {
            print("Invalid cart ID.")
            return
        }
        ApolloCartNetworkService.fetchCartById(cartId : cartID!, completion: {  result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                DispatchQueue.main.async{
                    self.cartResult = self.parseCartResponse(from: cartData)!
                    self.localCartResult = self.cartResult
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    var bindResultToShoppingCartCell : (()->()) = {}
    
    var cartQuantityResult = Cart()
    {
        didSet{
            bindResultToShoppingCartCell()
        }
    }

    func updateCartInModel(cartID : String?,lineQuantuty : Int? , lineID : String? , merchandiseId : String?) {
        guard cartID != nil else {
            print("Invalid cart ID.")
            return
        }
        ApolloCartNetworkService.updateLineBy(cartID: cartID, lineQuantuty: lineQuantuty, lineID: lineID, merchandiseId: merchandiseId, completion: { [weak self] result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                if !(cartData.cartLinesUpdate?.userErrors.isEmpty)!{
                    print((cartData.cartLinesUpdate?.userErrors.first?.message)!)
                }else{
                    let cart = cartData.cartLinesUpdate?.cart
                    self?.cartQuantityResult = Cart(id: cart?.id,quantity:cart?.totalQuantity)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteCartInModel(cartID : String?,lineID : [String]?) {
        guard cartID != nil else {
            print("Invalid cart ID.")
            return
        }
       /* ApolloCartNetworkService.DeleteLineBy(cartID: cartID, lineID: lineID, completion:{ [weak self] result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                if !(cartData.cartLinesRemove?.userErrors.isEmpty)!{
                    print((cartData.cartLinesRemove?.userErrors.first?.message)!)
                }else{
                    let cart = cartData.cartLinesRemove?.cart
                    self?.cartQuantityResult = Cart(id: cart?.id,quantity:cart?.totalQuantity)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })*/
    }
    
    
}
