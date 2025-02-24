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
        guard let cartData = data.cart else { return nil }
        
        func mapCost(amount: String? , currencyCode : String?) -> Cost? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return Cost(amount: "\(formattedPrice)", currencyCode: UserDefaults.standard.string(forKey: "currencyCode"))
        }
        
        let totalCost: TotalCost? = {
            let cost = cartData.cost
            return TotalCost(
                checkoutChargeAmount: mapCost(amount: cost.checkoutChargeAmount.amount, currencyCode: cost.checkoutChargeAmount.currencyCode.rawValue),
                subtotalAmount: mapCost(amount: cost.subtotalAmount.amount , currencyCode: cost.subtotalAmount.currencyCode.rawValue),
                totalAmount: mapCost(amount: cost.totalAmount.amount, currencyCode: cost.totalAmount.currencyCode.rawValue)
            )
        }()
        
        let cartItems: [Cart] = cartData.lines.edges.map { line in
            var cartItem = Cart()
            cartItem.id = line.node.id
            
            if let productVariant = line.node.merchandise.asProductVariant {
                var merch = Merchendise(id: productVariant.id, productTitle: productVariant.product.title , productId: productVariant.product.id)
                merch.availableQuantity = productVariant.quantityAvailable != nil ? productVariant.quantityAvailable! : 0
                merch.title = productVariant.title
                merch.image = productVariant.image?.url
                cartItem.merchandise = merch
            }
            
            cartItem.quantity = line.node.quantity
            
            cartItem.cost = {
                let lineCost = line.node.cost
                return TotalCost(
                    checkoutChargeAmount: mapCost(amount: lineCost.amountPerQuantity.amount, currencyCode: lineCost.amountPerQuantity.currencyCode.rawValue),
                    subtotalAmount: mapCost(amount: lineCost.subtotalAmount.amount, currencyCode: lineCost.subtotalAmount.currencyCode.rawValue),
                    totalAmount: mapCost(amount: lineCost.totalAmount.amount, currencyCode: lineCost.totalAmount.currencyCode.rawValue)
                )
            }()
            
            return cartItem
        }
        
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
        ApolloCartNetworkService.fetchCartById(cartId : cartID!, completion: {[weak self]  result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                DispatchQueue.main.async{
                    self?.cartResult = (self!.parseCartResponse(from: cartData)!)
                    self?.localCartResult = self!.cartResult
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
    
    func deleteCartInModel(cartID : String?,lineID : [String]? , indexPath :IndexPath) {
        guard cartID != nil else {
            print("Invalid cart ID.")
            return
        }
        ApolloCartNetworkService.DeleteLineBy(cartID: cartID, lineID: lineID, completion:{ [weak self] result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                if !(cartData.cartLinesRemove?.userErrors.isEmpty)!{
                    print((cartData.cartLinesRemove?.userErrors.first?.message)!)
                }else{
                    self?.getCartFromModel(cartID: cartID)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteLineInCart(cartID : String?,lineID : [String]?) {
        guard cartID != nil else {
            print("Invalid cart ID.")
            return
        }
        ApolloCartNetworkService.DeleteLineBy(cartID: cartID, lineID: lineID, completion:{ [weak self] result in
            switch result {
            case .success(let response):
                guard let cartData = response.data else {
                    print("Unable to extract raw data from response.")
                    return
                }
                if !(cartData.cartLinesRemove?.userErrors.isEmpty)!{
                    print((cartData.cartLinesRemove?.userErrors.first?.message)!)
                }else{
                    self?.getCartFromModel(cartID: cartID)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
