//
//  ListResultsViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import UIKit

protocol ListResultsViewControllerProtocol: AnyObject {
    func navigateToDetailedResultScreen()
    func alertSearchFailed()
    func alertNoResults()
}

class ListResultsViewController: UITableViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    struct Constant {
        static let alertSearchFailedTitle = "Busqueda Fallo"
        static let alertSearchFailedTitleMessage = "La busqueda fallo inesperadamente"
        static let alertNoResultsTitle = "Lo sentimos"
        static let alertNoResultsTitleMessage = "La busqueda no arroja ningun resultado"
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
}

extension ListResultsViewController: ListResultsViewControllerProtocol {
 
    func navigateToDetailedResultScreen() {
      //  let thirdView = ArtistLookUpViewController(nibName: "ArtistLookUp", bundle: nil)
      //  self.navigationController!.pushViewController(thirdView, animated: true)
    }
    
    
    func alertSearchFailed(){
        let alert = UIAlertController(title: Constant.alertSearchFailedTitle, message: Constant.alertSearchFailedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
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
