//
//  CoreDataManager.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 20/02/2025.
//


import Foundation
import CoreData
import UIKit

class CoreDataManager
{
    static var context : NSManagedObjectContext?
    static var appDelegate : AppDelegate?
    
    
    static func saveProductToCoreData(productName : String , productPrice : String, productImage: String , productId : String)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
       
        
        let entity = NSEntityDescription.entity(forEntityName: "WishList", in: myContext)
        
        guard let myEntity = entity else{return}
        
        do{
            
            let favProduct = NSManagedObject(entity: myEntity, insertInto: myContext)
            
            
            favProduct.setValue(productId, forKey: "productID")
            favProduct.setValue(productName, forKey: "productName")
            favProduct.setValue(productPrice, forKey: "productPrice")
            favProduct.setValue(productImage, forKey: "productImage")
            if let customerID = UserDefaults.standard.string(forKey: "customerID") {
                       favProduct.setValue(customerID, forKey: "customerID")  // Use customerID here
                   }

            print("Saved Successfully")
            
            try myContext.save()
            
        }catch let error{
            
            print(error.localizedDescription)
        }
    }
    
    
    static func deleteFromCoreData( productId :String)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "WishList")
           // let predictt = NSPredicate(format: "productName == %@",productName)
            //fetch.predicate = predictt
            
            let customerID = UserDefaults.standard.string(forKey: "customerID")
                    let predicate = NSPredicate(format: "productID == %@ AND customerID == %@", productId, customerID ?? "")
                    fetch.predicate = predicate
            let favProducts = try context?.fetch(fetch)
            
            guard let item = favProducts else {return}
            guard let itemFirst = item.first else {return}
            
             context?.delete(itemFirst)
            
            try context?.save()
            
            print("Deleted Succussfully")
            
        }catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    
    static func deleteAllData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        do{
            let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "WishList")
            let favProducts  = try context?.fetch(fetchReq)
            
            for i in 0..<(favProducts?.count)!{
                context?.delete((favProducts?[i])! )
                
                try context?.save()
                print(" data cleared scuccessfully! ")
            }
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    static func fetchFromCoreData() ->[FavoriteProduct]
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "WishList")
        
        var arrayOfFavProduct : [FavoriteProduct] = []
        
        if let customerID = UserDefaults.standard.string(forKey: "customerID") {
                let predicate = NSPredicate(format: "customerID == %@", customerID)
                fetch.predicate = predicate
            }
        
        do{
            
            
            
            let favProducts = try context?.fetch(fetch)
            
            guard let favItems = favProducts else{return []}
            
            for item in favItems
            {
                let productName = item.value(forKey: "productName")
                let productPrice = item.value(forKey: "productPrice")
                let productImage = item.value(forKey: "productImage")
                let productId = item.value(forKey: "productID")
              //  let productDesc = item.value(forKey: "productDesc")
                
                let product = FavoriteProduct(productId: productId as? String , productImage: productImage as? String , productName: productName as? String, productPrice: productPrice as? String )
            
                arrayOfFavProduct.append(product)
            }
            
        }catch let error
        {
            print(error.localizedDescription)
        }
        return arrayOfFavProduct
    }
    
}
class CoreDataServices{
    func saveToCoreData(completion: @escaping (Bool)-> Void){
        do{
            try context.save()
            completion(true)
        }catch{
            print("Error in saveProductToWishList", error.localizedDescription)
            completion(false)
        }
    }
}
