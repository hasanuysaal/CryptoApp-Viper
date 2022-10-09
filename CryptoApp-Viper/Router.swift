//
//  Router.swift
//  CryptoApp-Viper
//
//  Created by Hasan Uysal on 9.10.2022.
//

import Foundation
import UIKit.UIViewController

typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    
    static func startExecution() -> AnyRouter
    
}

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var presenter : AnyPresenter = CryptoPresenter()
        var view : AnyView = CryptoView()
        var interactor : AnyInteractor = CryptoInteractor()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
}
