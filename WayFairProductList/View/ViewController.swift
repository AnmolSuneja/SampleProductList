//
//  ViewController.swift
//  WayFairProductList
//
//  Created by Anmol Suneja on 05/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: ProductViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    func setupScreen() {
        viewModel.delegate = self
        tableView.register(UINib(nibName: ProductTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(product: viewModel.product(at: indexPath.row))
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: view.window?.windowScene?.screen.bounds.width ?? 320, height: 40)
        let label = UILabel(frame: rect)
        label.text = "Product Lists" //This constant can be part of a constant file. If there are things like localisation that would help
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: ProductListDelegate {
    func loadProduct() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorOcuured(error: any Error) {
        print("Error occured : \(error.localizedDescription)")
        // We can add a refersh control is api is failed
        // For better UI, we need to have a standard no data found UI
    }
}

// IF required, we may create different files for extension but here file size si limited so we may not need in this case
