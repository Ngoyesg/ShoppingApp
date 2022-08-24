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
}

class SearchLandingViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    struct Constant {
        static let alertSearchIsEmptyTitle = "Busqueda Vacia"
        static let alertSearchIsEmptyTitleMessage = "Por favor intente nuevamente"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let okAction = "OK"
    }
    
    var presenter: SearchLandingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
           // self.presenter = try SearchLandingPresenterBuilder().build()
            // self.presenter?.setViewController(self)
        } catch {
            alertInitializationFailed()
        }
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: { _ in fatalError()})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func onSearchButtonClicked(_ sender: Any) {
    //process clicked
    }
}

extension SearchLandingViewController: SearchLandingViewControllerProtocol {
 
    func navigateToListResultsScreen() {
        let secondView = ListResultsViewController(nibName: "ListResults", bundle: nil)
        self.navigationController!.pushViewController(secondView, animated: true)
    }
    
    func alertSearchWasEmpty(){
        let alert = UIAlertController(title: Constant.alertSearchIsEmptyTitle, message: Constant.alertSearchIsEmptyTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}
