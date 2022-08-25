//
//  ListResultsPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol ListResultsPresenterProtocol: AnyObject {
    func setViewController(_ viewController: ListResultsViewControllerProtocol)
    func sendRequest(for item: String)
    func getNumberOfRows()-> Int
    func getItem(for row: Int) -> ItemResults
    func itemWasSelected(at row: Int)
    func getThumbnail(for row: Int) -> Data? 
}

class ListResultsPresenter {
    
    enum Error: Swift.Error {
        case noResults, errorShowingData
    }
   
    weak var viewController: ListResultsViewControllerProtocol?
    
    var searchItemUseCase: SearchItemUseCaseProtocol
    
    var itemSearchResults: [ItemResults] = []

    init(searchItemUseCase: SearchItemUseCaseProtocol){
        self.searchItemUseCase = searchItemUseCase
    }
}

extension ListResultsPresenter: ListResultsPresenterProtocol {
   
    func setViewController(_ viewController: ListResultsViewControllerProtocol){
        self.viewController = viewController
        self.viewController?.startSpinner()
    }
    
    func sendRequest(for item: String) {
        searchItemUseCase.execute(search: item) { [weak self] productsData in
            guard let self = self, let controller = self.viewController else {
                return
            }
            self.itemSearchResults = productsData.results
            controller.stopSpinner()
            controller.showTable()
            controller.reloadTableView()
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.stopSpinner()
            controller.alertDownloadingFailed()
        }
    }
    
    func requestThumbnail(for thumbnail: String) -> Data? {
        var thumbnailData: Data? = nil
        searchItemUseCase.getThumbnail(search: thumbnail) { [weak self] downloadedData in
            guard let self = self, let controller = self.viewController else {
                return
            }
            thumbnailData = downloadedData
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            thumbnailData = nil
        }
        return thumbnailData
    }
    
    func getNumberOfRows()-> Int{
        return itemSearchResults.count
    }
    func getItem(for row: Int) -> ItemResults {
        return itemSearchResults[row]
    }
    
    func getThumbnail(for row: Int) -> Data? {
        let itemThumbnail = itemSearchResults[row].characteristics.thumbnail
        let data = self.requestThumbnail(for: itemThumbnail)
        return data
    }
    
    func itemWasSelected(at row: Int){
        let selectedItem = itemSearchResults[row]
        // sennd the ID to the other controller controller?.goToArtDetailsViewController()
    }
}
