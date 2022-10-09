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
        
        
    }
    
}
