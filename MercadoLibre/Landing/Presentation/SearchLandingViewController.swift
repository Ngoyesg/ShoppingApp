//
//  SearchLandingViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import UIKit

protocol SearchLandingViewControllerProtocol: AnyObject {
    func navigateToListResultsScreen()
    func alertSearchWasEmpty()
    func setItemToSearch(as item: String)
}

class SearchLandingViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    struct Constant {
        static let alertSearchIsEmptyTitle = "Busqueda Vacia"
        static let alertSearchIsEmptyTitleMessage = "Por favor intente nuevamente"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let okAction = "OK"
        static let segueToListResults = "toListResults"
    }
    
    var presenter: SearchLandingPresenterProtocol?
    var itemToSearch: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchLandingPresenterBuilder().build()
        guard let presenter = presenter else {
            alertInitializationFailed()
            return
        }
        presenter.setViewController(self)
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in fatalError()})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func onSearchButtonClicked(_ sender: Any) {
        self.presenter?.processSearchClicked(for: searchTextField.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListResultsViewController {
            if let itemToSearch = itemToSearch {
                destination.setItemToSearch(with: itemToSearch)
            }
        }
    }
    
}

extension SearchLandingViewController: SearchLandingViewControllerProtocol {
    
    func navigateToListResultsScreen() {
        self.performSegue(withIdentifier: Constant.segueToListResults, sender: self)
    }
    
    func alertSearchWasEmpty(){
        let alert = UIAlertController(title: Constant.alertSearchIsEmptyTitle, message: Constant.alertSearchIsEmptyTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func setItemToSearch(as item: String) {
        self.itemToSearch = item
    }
}
