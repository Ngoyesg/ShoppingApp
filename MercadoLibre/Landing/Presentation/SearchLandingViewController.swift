//
//  SearchLandingViewController.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import UIKit

protocol SearchLandingViewControllerProtocol: AnyObject {
    func enableSearchButton()
    func disableSearchButton()
    func navigateToListResultsScreen()
    func alertSearchWasEmpty()
    func setItemToSearch(as item: String)
    func alertCountryIsEmpty()
    func reloadPicker()
}

class SearchLandingViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var countryPicker: UIPickerView!
    
    struct Constant {
        static let alertSearchIsEmptyTitle = "Busqueda Vacia"
        static let alertSearchIsEmptyTitleMessage = "Por favor intente nuevamente"
        static let alertInitializationFailedTitle = "Error"
        static let alertInitializationFailedTitleMessage = "Fallo al cargar vista"
        static let alertCountryUnselectedTitle = "Error"
        static let alertCountryUnselectedTitleMessage = "Por favor seleccione un pais"
        static let okAction = "OK"
        static let segueToListResults = "toListResults"
    }
    
    var presenter: SearchLandingPresenterProtocol?
    var itemToSearch: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        do {
            self.presenter = try SearchLandingPresenterBuilder().build()
            self.presenter?.setViewController(self)
        } catch {
            alertInitializationFailed()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.verifyCountrySelection()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    func alertCountryIsEmpty(){
        let alert = UIAlertController(title: Constant.alertCountryUnselectedTitle, message: Constant.alertCountryUnselectedTitleMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func setItemToSearch(as item: String) {
        self.itemToSearch = item
    }
    
    func enableSearchButton(){
        self.searchButton.isEnabled = true
    }
    
    func disableSearchButton(){
        self.searchButton.isEnabled = false
    }
      
}

extension SearchLandingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter?.getRowsForPicker() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.getTitleForPicker(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter?.countryWasSelected(at: row)
    }
    
    func reloadPicker(){
        countryPicker.reloadAllComponents()
    }
    
}
