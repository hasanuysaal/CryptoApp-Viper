//
//  Presenter.swift
//  CryptoApp-Viper
//
//  Created by Hasan Uysal on 9.10.2022.
//

import Foundation


enum NetworkError : Error {
    
    case wrongUrl
    case dataCantGet
    case dataCantProcess
    
}

protocol AnyPresenter {
    
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    
    func interactorDidDownloadData(result: Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    func interactorDidDownloadData(result: Result<[Crypto], Error>) {
       
        switch result{
            case .success(let cryptos):
                // view.update()
                print("success")
            case .failure(let error):
                //view.showError()
                print("failure")
        }
    }
    
}
