//
//  DetailedItemViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import UIKit

protocol DetailedItemViewControllerProtocol: AnyObject {
    func setItemToSearch(with item: ProductsToDisplay)
}

class DetailedItemViewController: UIViewController {
    
}

extension DetailedItemViewController: DetailedItemViewControllerProtocol {
    
    func setItemToSearch(with item: ProductsToDisplay) {
        //presenter?.sendRequest(for: item)
    }
}
