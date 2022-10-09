//
//  Interactor.swift
//  CryptoApp-Viper
//
//  Created by Hasan Uysal on 9.10.2022.
//

import Foundation

protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            self.presenter?.interactorDidDownloadData(result: .failure(NetworkError.wrongUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadData(result: .failure(NetworkError.dataCantGet))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadData(result: .success(cryptos))
                
            } catch {
                self?.presenter?.interactorDidDownloadData(result: .failure(NetworkError.dataCantProcess))
            }
        
        
        }
        
        task.resume()
        
    
}
}
