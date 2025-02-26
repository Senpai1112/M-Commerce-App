//
//  formattedDate.swift
//  Shopify
//
//  Created by Mai Atef  on 25/02/2025.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "EET")
        guard let date = dateFormatter.date(from: self) else { return "Invalid Date" }

        dateFormatter.dateFormat = "d MMMM yyyy • hh:mm a"
        return dateFormatter.string(from: date)
    }
}
