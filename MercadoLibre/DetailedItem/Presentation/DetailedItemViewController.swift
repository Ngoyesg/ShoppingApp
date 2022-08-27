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
    func alertDownloadingFailed()
    func showTable()
    func startSpinner()
    func stopSpinner()
    func reloadTableView()
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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
 
    struct Constant {
        static let tableTile = "Preguntas y respuestas"
        static let alertNoResultsTitle = "Sin Datos"
        static let alertNoResultsTitleMessage = "Por favor intente nuevamente"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let alertDownloadingFailedTitle = "Busqueda Fallo"
        static let alertDownloadingFailedTitleMessage = "La busqueda fallo inesperadamente"
        static let okAction = "OK"
        static let segueToListResults = "toListResults"
        static let cellIdentifier = "questionAnswerCell"
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.requestQAndAs()
        self.presenter?.loadView()
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
    
    func alertDownloadingFailed(){
        let alert = UIAlertController(title: Constant.alertDownloadingFailedTitle, message: Constant.alertDownloadingFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in
            self.dismiss(animated: true) })
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
            self.installmentsLabel.text = "No puedes llevar este producto a cuotas"
        }
    }
    
    func showTable() {
        tableView.isHidden = false
    }
    
    func startSpinner() {
        self.spinner.startAnimating()
    }
    
    func stopSpinner() {
        self.spinner.stopAnimating()
    }
    
}

extension DetailedItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constant.tableTile
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath)
        let cellInfo = presenter?.getQAndAs(for: indexPath.row)
        
        
        if let question = cellInfo?.question, let date = cellInfo?.date {
            cell.textLabel?.text = "\(question) - Fecha: \(date.prefix(10))"
        } else if let question = cellInfo?.question {
            cell.textLabel?.text = "\(question)"
        }
        
        if let answer = cellInfo?.answer?.text {
            cell.detailTextLabel?.text = "\(answer)"
        } else {
            cell.detailTextLabel?.text = "No hay respuesta"
        }
        
        return cell
    }
   
    func reloadTableView() {
        tableView.reloadData()
    }
}
