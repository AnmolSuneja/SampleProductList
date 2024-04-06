//
//  Product.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import Foundation

struct Product: Codable {
    let name: String
    let tagline: String
    private let rating: Double
    let date: String
    
    var roundedRating: String {
        // We can move this rounded logic to separate helper file so that it is accessible from multiple places if required
        func roundToNearestHalf(number: Double) -> String {
            let roundedNumber = (number * 2).rounded() / 2
            let formattedNumber = String(format: "%.1f", roundedNumber)
            return formattedNumber.replacingOccurrences(of: ".0", with: "")
        }

        return roundToNearestHalf(number: rating)
    }
    
    /*
    // Although each product should be having the data but sometimes api don't return expected response so in order to avoid that we can make these properties as variables
    let name: String?
    let tagline: String?
    let ratingNew: Double? // Like rating key name been mistakenly changed at server end
    let date: String?
     */
}
