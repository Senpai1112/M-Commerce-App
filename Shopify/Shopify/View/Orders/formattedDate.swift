//
//  formattedDate.swift
//  Shopify
//
//  Created by Mai Atef  on 25/02/2025.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let datee = DateFormatter()
        datee.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = datee.date(from: self) else { return "Invalid Date" }

        datee.dateFormat = "MMM d, yyyy • h:mm a"
        return datee.string(from: date)
    }
}
