//
//  UnitTestViewController.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit

final class UnitTestViewController: UIViewController {
    var testingLabel: UILabel!
    var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        testingLabel = UILabel()
        testingLabel.text = "Testing..."
        testingLabel.textAlignment = .center
        testingLabel.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        view.addSubview(testingLabel)
        
        indicator = UIActivityIndicatorView()
        
        if #available(iOS 13, *) {
            indicator.style = .medium
        } else {
            indicator.style = .gray
        }
        
        indicator.startAnimating()
        view.addSubview(indicator)
        
        // constraint
        testingLabel.translatesAutoresizingMaskIntoConstraints = false
        testingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: testingLabel.bottomAnchor, constant: 18).isActive = true
    }
}
