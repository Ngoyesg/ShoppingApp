//
//  DetailedItemViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import UIKit

protocol DetailedItemViewControllerProtocol: AnyObject {
    func setItemToDisplay(with item: ProductsToDisplay)
    func setImage(with data: Data?)
    func setSoldItems(with quantity: Int?)
    func setAvailableItems(with quantity: Int?)
    func setItemDescription(with description: String)
    func setPrice(with price: Double?, currency id: String?)
    func setInstallment(with amount: Double?, for time: Int?)
    func alertNoData()
}

class DetailedItemViewController: UIViewController {
    
    var presenter: DetailedItemPresenterProtocol?
    var itemToDisplay: ProductsToDisplay?
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var soldItemsLabel: UILabel!
    
    @IBOutlet weak var availableItemsLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var installmentsLabel: UILabel!
 
    struct Constant {
        static let alertNoResultsTitle = "Sin Datos"
        static let alertNoResultsTitleMessage = "Por favor intente nuevamente"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let okAction = "OK"
        static let segueToListResults = "toListResults"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.presenter = try DetailedItemPresenterBuilder().build()
            self.presenter?.setViewController(self)
            self.presenter?.setProductData(with: itemToDisplay!)
        } catch {
            alertInitializationFailed()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.loadView()
    }
    
    @IBAction func onWantItButtonClicked(_ sender: Any) {
        //presenter.processIwantItButton
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in fatalError()})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension DetailedItemViewController: DetailedItemViewControllerProtocol {
    
    func setItemToDisplay(with item: ProductsToDisplay) {
        self.itemToDisplay = item
    }
    
    func alertNoData(){
        let alert = UIAlertController(title: Constant.alertNoResultsTitle, message: Constant.alertNoResultsTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func setImage(with data: Data?) {
        if let data = data {
            self.itemImage.image = UIImage(data: data)
        } else {
            self.itemImage.image = #imageLiteral(resourceName: "errorImage")
        }
    }
    
    func setSoldItems(with quantity: Int?) {
        self.soldItemsLabel.text = "Vendidos: \(quantity ?? 0)"
    }
    
    func setAvailableItems(with quantity: Int?) {
        self.availableItemsLabel.text = "Disponibles: \(quantity ?? 0)"
    }

    func setItemDescription(with description: String) {
        self.itemDescriptionLabel.text = description
    }

    func setPrice(with price: Double?, currency id: String?) {
        self.priceLabel.text = "$\(price ?? 0.0) \(id ?? "")"
    }

    func setInstallment(with amount: Double?, for time: Int?) {
        if let amount = amount, let time = time {
            self.installmentsLabel.text = "$\(amount) por \(time) meses"
        } else {
            self.installmentsLabel.isHidden = true
        }
    }
}

