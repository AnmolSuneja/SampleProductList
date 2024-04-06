//
//  ProductViewModel.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import Foundation

protocol ProductListDelegate: AnyObject {
    func loadProduct()
    func errorOcuured(error: Error)
}

class ProductViewModel {
    private var list: [Product] = []
    weak var delegate: ProductListDelegate? {
        didSet {
            loadList()
        }
    }
    
    private func loadList() {
        // The Url should be part of a constants file. Where base and end point urls would be two separate constants
        NetworkManager.shared.fetchProductList(endpoint: "https://api.wayfair.io/interview-sandbox/android/json-to-list/products.v1.json") { [weak self] (result: Result<[Product], Error>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let products):
                self.list = products
                self.delegate?.loadProduct()
            case .failure(let error):
                self.delegate?.errorOcuured(error: error)
            }
        }
    }
    
    var numberOfProducts: Int {
        list.count
    }
    
    func product(at index: Int) -> Product {
        list[index]
    }
}
