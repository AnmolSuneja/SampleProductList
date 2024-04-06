//
//  ProductTableViewCell.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell, ReuseableInterface {
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    func resetCell() {
        // We actually need to reset cell so that previous values of any product are not there when we are making product properties optionals in case to handle server side errors
        let placeholderConstant = "--"//This constant can be part of a constant file. If there are things like localisation that would help
        lblProductName.text = placeholderConstant
        lblTagline.text = placeholderConstant
        lblRating.text = placeholderConstant
        lblDate.text = placeholderConstant
    }
    
    func configureCell(product: Product) {
        lblProductName.text = product.name
        lblTagline.text = product.tagline
        lblRating.text = product.roundedRating
        lblDate.text = product.date
    }
}
