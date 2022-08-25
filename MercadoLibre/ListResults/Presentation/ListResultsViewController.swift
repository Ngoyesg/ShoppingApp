//
//  ListResultsViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import UIKit

protocol ListResultsViewControllerProtocol: AnyObject {
    func setItemToSearch(with item: String)
    func navigateToDetailedResultScreen()
    func alertDownloadingFailed()
    func alertNoResults()
    func showTable()
    func startSpinner()
    func stopSpinner()
    func reloadTableView()
}

class ListResultsViewController: UIViewController {
    
    @IBOutlet var tableViewListResults: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    struct Constant {
        static let cellIndentifier = "itemCell"
        static let alertDownloadingFailedTitle = "Busqueda Fallo"
        static let alertDownloadingFailedTitleMessage = "La busqueda fallo inesperadamente"
        static let alertNoResultsTitle = "Lo sentimos"
        static let alertNoResultsTitleMessage = "La busqueda no arroja ningun resultado"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let okAction = "OK"
        static let segueToDetailedProduct = "toDetailedProduct"
    }
    
    var itemToSearch: String = ""
    var productToSend: ProductsToDisplay?
    var presenter: ListResultsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewListResults.delegate = self
        tableViewListResults.dataSource = self
        
        do {
            self.presenter = try ListResultsPresenterBuilder().build()
            self.presenter?.setViewController(self)
            self.presenter?.sendRequest(for: itemToSearch)
        } catch {
            alertInitializationFailed()
        }
    }
    
    func setItemToSearch(with item: String) {
        self.itemToSearch = item
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in fatalError()})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedItemViewControllerProtocol {
            if let productToSend = productToSend {
                destination.setItemToSearch(with: productToSend)
            }
        }
    }
    
}

extension ListResultsViewController: ListResultsViewControllerProtocol {
 
    func navigateToDetailedResultScreen() {
      //  let thirdView = ArtistLookUpViewController(nibName: "ArtistLookUp", bundle: nil)
      //  self.navigationController!.pushViewController(thirdView, animated: true)
    }
    
    func showTable(){
        tableViewListResults.isHidden = false
    }

    func startSpinner(){
        spinner.startAnimating()
    }
    
    func stopSpinner(){
        spinner.stopAnimating()
    }
        
    func alertDownloadingFailed(){
        let alert = UIAlertController(title: Constant.alertDownloadingFailedTitle, message: Constant.alertDownloadingFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in
            self.dismiss(animated: true) })
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func alertNoResults(){
        let alert = UIAlertController(title: Constant.alertNoResultsTitle, message: Constant.alertNoResultsTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in fatalError()})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension ListResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewListResults.dequeueReusableCell(withIdentifier: Constant.cellIndentifier, for: indexPath)
        let cellInfo = presenter?.getItem(for: indexPath.row)
        let itemThumbnail = presenter?.getThumbnail(for: indexPath.row)
        if let thumbnail = itemThumbnail {
            cell.imageView?.image = UIImage(data: thumbnail)
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "errorImage")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.itemWasSelected(at: indexPath.row)
    }
    
    func reloadTableView(){
        tableViewListResults.reloadData()
    }
}
