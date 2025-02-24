//
//  CurrencyApiService.swift
//  Shopify
//
//  Created by Yasser Yasser on 22/02/2025.
//

import Foundation

protocol CurrencyService{
    static func fetchCurreny(complitionHandler: @escaping(CurrencyModel?)->Void)
}

class CurrencyApiService : CurrencyService{
    static func fetchCurreny(complitionHandler: @escaping (CurrencyModel?) -> Void) {
        let url = URL(string: "https://api.currencyapi.com/v3/latest?apikey=cur_live_twrdnErGJRHOy4u5N1tzCuEjoAM7fJjEfRSzME6p&currencies=EUR%2CUSD%2CCAD&base_currency=EGP")
        guard let url = url else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){
            data,response,error  in
            guard let guardedData = data else
            {
                return
            }
            do {
                let result = try JSONDecoder().decode(CurrencyModel.self, from: guardedData)
                complitionHandler(result)
            }catch
            {
                print(error.localizedDescription)
                complitionHandler(nil)
            }
        }
        task.resume()
    }
}
