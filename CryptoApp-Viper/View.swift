//
//  View.swift
//  CryptoApp-Viper
//
//  Created by Hasan Uysal on 9.10.2022.
//

import Foundation
import UIKit

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos : [Crypto])
    func update(with error : String)
    
    
}

class CryptoView : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading ..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let myView : UIView = {
        let view = UIView()
        view.isHidden = false
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting display mode light even if user set the mode dark
        //overrideUserInterfaceStyle = .light
        // OR
        //info.plist set Apperance to Dark or Light
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(myView)
        view.addSubview(messageLabel)
        
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let uiStyle = traitCollection.userInterfaceStyle
        
        if uiStyle == .dark {
            
            messageLabel.textColor = .black
            myView.backgroundColor = .white
            
        } else {
            
            view.backgroundColor = .white
            messageLabel.textColor = .white
            myView.backgroundColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
        addConstraints()
    
    }
    
    private func addConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(myView.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(myView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(myView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(myView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        constraints.append(messageLabel.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 0.5))
        constraints.append(messageLabel.heightAnchor.constraint(equalTo: myView.heightAnchor, multiplier: 0.5))
        constraints.append(messageLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor))
        constraints.append(messageLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.myView.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
        
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
}
